return {
  'nvim-tree/nvim-tree.lua',
  lazy = false,
  config = function()
    require("nvim-tree").setup({
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
      icons = {
          git_placement = 'after',
          show = {
            git = false
          }
      },
    },
    filters = {
      dotfiles = true,
    },
  })
  end
}
