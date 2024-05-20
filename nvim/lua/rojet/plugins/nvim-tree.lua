return {
  'nvim-tree/nvim-tree.lua',
  lazy = false,
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 30,
      },

      --opens nvim tree wrt current buffer
      update_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
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
