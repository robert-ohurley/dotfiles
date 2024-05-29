return {
    'tpope/vim-fugitive',
    event = 'VimEnter',
    opts = {},
    config = function()
        vim.keymap.set('n', '<leader>G', vim.cmd.Git)
    end
  }
