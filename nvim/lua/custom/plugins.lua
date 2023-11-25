local plugins = {
  {
    "williamboman/mason.nvim",
    opts={
      ensure_installed = {
        "typescript-language-server",
        "gopls"
      }
    }
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "custom.configs.lint"
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins/configs/lspconfig"
      require "custom/configs/lspconfig"
    end,
  }
}

return plugins
