return {
  'ThePrimeagen/harpoon',
  event = 'VimEnter',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon.setup()

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add to Harpoon' })
    vim.keymap.set('n', '<leader>h', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Toggle Harpoon' })

    vim.keymap.set('n', '<A-h>', function()
      harpoon:list():prev()
    end, { desc = 'Prev Harpoon' })
    vim.keymap.set('n', '<A-l>', function()
      harpoon:list():next()
    end, { desc = 'Next Harpoon' })
  end,
}
