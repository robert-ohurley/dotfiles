return {
  'ggandor/leap.nvim',
  opts = {},
  config = function()
    vim.keymap.set('n', 'm', function()
      require('leap').leap { backward = false }
    end)
    vim.keymap.set('n', 'M', function()
      require('leap').leap { backward = false }
    end)
  end,
}
