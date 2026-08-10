-- Working out what a branch was forked from.
--
-- Git doesn't record it, so the base branch is resolved in three steps: an
-- explicit `branch.<name>.base` git config wins, otherwise guess the nearest
-- branch, otherwise fall back to the trunk.
--
-- Shared by gitsigns (which shades the sign gutter against the base) and
-- diffview (which diffs the whole branch against it), so both agree and a
-- :GitBase pin applies to each.

local M = {}

function M.git(dir, ...)
  local out = vim.fn.systemlist { 'git', '-C', dir, ... }
  if vim.v.shell_error ~= 0 then
    return nil
  end
  return out
end

function M.git1(dir, ...)
  local out = M.git(dir, ...)
  return out and out[1]
end

function M.repo_dir()
  local dir = vim.fn.expand '%:p:h'
  if dir == '' then
    dir = vim.fn.getcwd()
  end
  return dir
end

-- Trunk fallback: origin/HEAD, else a local master/main.
function M.trunk(dir)
  local remote_head = M.git1(dir, 'symbolic-ref', '--short', 'refs/remotes/origin/HEAD')
  if remote_head then
    return remote_head
  end
  for _, branch in ipairs { 'master', 'main' } do
    if M.git1(dir, 'rev-parse', '--verify', '--quiet', branch) then
      return branch
    end
  end
end

-- Guess the parent: of every other branch, the one whose merge-base with HEAD
-- sits furthest along the branch is the likeliest fork point. Compared by
-- ancestry rather than commit date, since sibling commits often share a
-- timestamp and dates can run backwards after a rebase or cherry-pick.
function M.guess_parent(dir, current)
  local refs = M.git(dir, 'for-each-ref', '--format=%(refname:short)', 'refs/heads', 'refs/remotes/origin')
  if not refs then
    return nil
  end

  local function is_ancestor(a, b)
    vim.fn.system { 'git', '-C', dir, 'merge-base', '--is-ancestor', a, b }
    return vim.v.shell_error == 0
  end

  -- Tie-break when candidates share the exact same merge-base. A branch whose
  -- tip *is* the fork point is the one actually branched off, so it beats the
  -- trunk -- which ties whenever the parent has since been merged into it.
  -- Falling back to the trunk covers siblings forked from the same commit.
  local trunk_ref = M.trunk(dir)
  local function rank_of(ref, mb)
    if M.git1(dir, 'rev-parse', '--verify', '--quiet', ref) == mb then
      return 3
    elseif ref == trunk_ref then
      return 2
    elseif ref == 'master' or ref == 'main' then
      return 1
    end
    return 0
  end

  local best, best_mb, best_rank

  for _, ref in ipairs(refs) do
    if ref ~= current and ref ~= 'origin/' .. current and ref ~= 'origin/HEAD' then
      -- Skip descendants: `HEAD is an ancestor of ref` means ref forked later,
      -- off this branch, so it can't be the parent.
      if not is_ancestor('HEAD', ref) then
        local mb = M.git1(dir, 'merge-base', 'HEAD', ref)
        if mb then
          local rank = rank_of(ref, mb)
          if not best_mb then
            best, best_mb, best_rank = ref, mb, rank
          elseif mb == best_mb then
            if rank > best_rank then
              best, best_rank = ref, rank
            end
          elseif is_ancestor(best_mb, mb) then
            -- This fork point is further along than the incumbent's.
            best, best_mb, best_rank = ref, mb, rank
          end
        end
      end
    end
  end

  return best
end

-- Returns the base ref plus how it was determined, for the notification.
function M.resolve_base_ref(dir)
  local current = M.git1(dir, 'branch', '--show-current')

  if current and current ~= '' then
    local configured = M.git1(dir, 'config', '--get', 'branch.' .. current .. '.base')
    if configured and configured ~= '' then
      return configured, 'pinned'
    end
  end

  local guessed = current and current ~= '' and M.guess_parent(dir, current)
  if guessed then
    return guessed, 'guessed'
  end

  local fallback = M.trunk(dir)
  if fallback then
    return fallback, 'trunk fallback'
  end
end

-- The commit this branch forked at, as a sha. Returns nil plus a reason.
function M.fork_point(dir)
  dir = dir or M.repo_dir()

  local ref, how = M.resolve_base_ref(dir)
  if not ref then
    return nil, 'could not work out a base branch'
  end

  local mb = M.git1(dir, 'merge-base', 'HEAD', ref)
  if not mb then
    return nil, 'merge-base with ' .. ref .. ' failed'
  end

  return mb, nil, ref, how
end

return M
