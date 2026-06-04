return {
  "robert-ohurley/compass.nvim",
  keys = {
    { '<C-j>', '<cmd>CompassBack<CR>', desc = 'Compass Back' },
    { '<C-k>', '<cmd>CompassForward<CR>', desc = 'Compass Forward' },
    { '<C-l>', '<cmd>CompassDebugDump<CR>', desc = 'Compass Debug Info' },
  },
  opts = {
    history = {
      mode = "graph", -- "graph" | "linear"
    },
  },
}
