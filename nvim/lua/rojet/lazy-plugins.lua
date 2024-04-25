-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  require 'rojet.plugins.autoformat',
  require 'rojet.plugins.autocomplete',
  require 'rojet.plugins.cloak',
  require 'rojet.plugins.colorscheme',
  require 'rojet.plugins.fugitive',
  require 'rojet.plugins.gitsigns',
  require 'rojet.plugins.harpoon',
  require 'rojet.plugins.lsp',
  require 'rojet.plugins.misc',
  require 'rojet.plugins.nvim-tmux-navigator',
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
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
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
