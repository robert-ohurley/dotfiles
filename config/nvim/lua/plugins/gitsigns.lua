-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do

-- Base-branch resolution lives in rojet.git so gitsigns and diffview agree,
-- and a :GitBase pin applies to both.

local git = require 'rojet.git'

-- nil = default (diff against the index), otherwise the merge-base commit.
local branch_base = nil

-- Toggle the sign gutter between "uncommitted changes" and "everything unique
-- to this branch". Diffs against the merge-base, so commits landing on the
-- parent branch afterwards don't pollute the signs.
local function toggle_branch_base()
  local gitsigns = require 'gitsigns'

  if branch_base then
    branch_base = nil
    gitsigns.change_base(nil, true)
    vim.notify('gitsigns: base = index', vim.log.levels.INFO)
    return
  end

  local dir = git.repo_dir()
  local ref, how = git.resolve_base_ref(dir)
  if not ref then
    vim.notify('gitsigns: could not work out a base branch', vim.log.levels.WARN)
    return
  end

  local mb = git.git1(dir, 'merge-base', 'HEAD', ref)
  if not mb then
    vim.notify('gitsigns: merge-base with ' .. ref .. ' failed', vim.log.levels.WARN)
    return
  end

  branch_base = mb
  gitsigns.change_base(mb, true)

  vim.notify('gitsigns: base branch = ' .. ref .. ' (' .. how .. ')', vim.log.levels.INFO)
end

-- :GitBase          show the base for the current branch
-- :GitBase <ref>    pin it (persists in .git/config)
-- :GitBase!         clear the pin and go back to guessing
vim.api.nvim_create_user_command('GitBase', function(cmd)
  local dir = git.repo_dir()
  local current = git.git1(dir, 'branch', '--show-current')
  if not current or current == '' then
    vim.notify('GitBase: not on a branch', vim.log.levels.WARN)
    return
  end
  local key = 'branch.' .. current .. '.base'

  if cmd.bang then
    git.git(dir, 'config', '--unset', key)
    vim.notify('GitBase: cleared pin for ' .. current, vim.log.levels.INFO)
  elseif cmd.args ~= '' then
    if not git.git1(dir, 'rev-parse', '--verify', '--quiet', cmd.args) then
      vim.notify('GitBase: no such ref: ' .. cmd.args, vim.log.levels.ERROR)
      return
    end
    if not git.git(dir, 'config', key, cmd.args) then
      vim.notify('GitBase: failed to write ' .. key, vim.log.levels.ERROR)
      return
    end
    vim.notify('GitBase: ' .. current .. ' -> ' .. cmd.args, vim.log.levels.INFO)
  else
    local ref, how = git.resolve_base_ref(dir)
    vim.notify('GitBase: ' .. (ref or 'unknown') .. ' (' .. (how or 'none') .. ')', vim.log.levels.INFO)
    return
  end

  -- Re-apply if the branch-base view is currently active.
  if branch_base then
    branch_base = nil
    toggle_branch_base()
  end
end, {
  nargs = '?',
  bang = true,
  desc = 'Show/set/clear the branch this diff is based on',
  complete = function()
    local refs = git.git(git.repo_dir(), 'for-each-ref', '--format=%(refname:short)', 'refs/heads', 'refs/remotes')
    return refs or {}
  end,
})

return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }

        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })
        -- Toggles
        --
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
        map('n', '<leader>tB', toggle_branch_base, { desc = '[T]oggle git signs vs [B]ranch base' })
      end,
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
