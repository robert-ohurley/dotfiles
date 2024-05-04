return {
    'tpope/vim-fugitive',
    event = 'VimEnter',
    opts = {},
    config = function()
        vim.keymap.set('n', '<leader>g', vim.cmd.Git)
    end
  }
