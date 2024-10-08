require('lazy').setup({
  require 'rojet.plugins.autoformat',
  require 'rojet.plugins.alpha',
  require 'rojet.plugins.autocomplete',
  require 'rojet.plugins.cloak',
  require 'rojet.plugins.colorscheme',
  require 'rojet.plugins.gitsigns',
  require 'rojet.plugins.gopher',
  require 'rojet.plugins.harpoon',
  require 'rojet.plugins.lazygit',
  require 'rojet.plugins.lint',
  require 'rojet.plugins.lsp',
  require 'rojet.plugins.misc',
  require 'rojet.plugins.nvim-tmux-navigator',
  require 'rojet.plugins.nvim-tree',
  require 'rojet.plugins.telescope',
  require 'rojet.plugins.treesitter',
  require 'rojet.plugins.undotree',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
