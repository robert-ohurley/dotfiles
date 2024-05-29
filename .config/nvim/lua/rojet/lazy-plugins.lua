require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  require 'rojet.plugins.autoformat',
  require 'rojet.plugins.autocomplete',
  require 'rojet.plugins.cloak',
  require 'rojet.plugins.colorscheme',
  require 'rojet.plugins.fugitive',
  require 'rojet.plugins.gitsigns',
  require 'rojet.plugins.harpoon',
  require 'rojet.plugins.lazygit',
  require 'rojet.plugins.lsp',
  require 'rojet.plugins.misc',
  require 'rojet.plugins.nvim-tmux-navigator',
  require 'rojet.plugins.nvim-tree',
  require 'rojet.plugins.telescope',
  require 'rojet.plugins.treesitter',
  require 'rojet.plugins.undotree',
  require 'rojet.plugins.which-key',
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
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
