return {
  dir = "/home/rob/dev/compass.nvim",
  name = "compass",
  config = function()
    require("compass").setup({
      history = {
        mode = "graph",
      },
      ui = {
        chooser = "ui.select",
      },
      debug = false,
    })

    vim.keymap.set('n', '<C-u>', '<cmd>CompassBack<CR>', { desc = '[C]ompass [B]ack' })
    vim.keymap.set('n', '<C-i>', '<cmd>CompassForward<CR>', { desc = '[C]ompass [F]orward' })
    vim.keymap.set('n', '<C-o>', '<cmd>CompassDebugDump<CR>', { desc = '[C]ompass [D]ebug dump' })
  end,
}
