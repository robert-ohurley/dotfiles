-- Base-branch resolution lives in rojet.git, shared with gitsigns, so both
-- agree on what this branch forked from and a :GitBase pin applies to each.

local git = require 'rojet.git'

local function with_fork_point(fn)
  return function()
    local base, err, ref, how = git.fork_point()
    if not base then
      return vim.notify('diffview: ' .. err, vim.log.levels.WARN)
    end

    vim.notify('diffview: base = ' .. ref .. ' (' .. how .. ')', vim.log.levels.INFO)
    fn(base)
  end
end

-- The whole branch: fork point to working tree. --imply-local points the HEAD
-- side at the files on disk, so uncommitted work shows and the right side
-- keeps LSP and treesitter.
local branch_diff = with_fork_point(function(base)
  vim.cmd('DiffviewOpen ' .. base .. '...HEAD --imply-local')
end)

-- The same range as a list of commits rather than one flattened diff.
local branch_history = with_fork_point(function(base)
  vim.cmd('DiffviewFileHistory --range=' .. base .. '..HEAD')
end)

return {
  "sisdafskajfndrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  keys = {
    { '<leader>gd', branch_diff,                        desc = 'View branch [g]it [d]iff' },
    { '<leader>gh', branch_history,                     desc = 'View branch [g]it [h]istory' },
    { '<leader>gf', '<cmd>DiffviewFileHistory %<cr>',   desc = 'View [g]it history of this [f]ile' },
    { '<leader>gq', vim.cmd.DiffviewClose,              desc = '[g]it diff [q]uit' },
    { '<leader>gB', '<cmd>GitBase<cr>',                 desc = 'Show [g]it [B]ase branch' },
  },
}
