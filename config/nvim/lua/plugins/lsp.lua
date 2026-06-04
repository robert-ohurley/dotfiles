return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        clangd = {},
        gopls = {},
        bashls = {
          filetypes = { 'bash', 'sh', 'zsh' },
        },
        jsonls = {
          filetypes = { 'json' },
        },
        pyright = {},
        ruby_lsp = {
          filetypes = { 'ruby' },
          -- cmd = { vim.fn.stdpath('data') .. '/mason/bin/ruby-lsp' },
          init_options = {
            enabledFeatures = {
              'codeActions',
              'codeLens',
              'completion',
              'diagnostics',
              'documentHighlights',
              'documentLink',
              'documentSymbols',
              'foldingRanges',
              'formatting',
              'hover',
              'inlayHint',
              'onTypeFormatting',
              'selectionRanges',
              'semanticHighlighting',
              'signatureHelp',
              'workspaceSymbol',
            },
          },
        },
        ts_ls = {
          filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
          on_attach = function(client, bufnr)
            -- Disable ts_ls for glimmer files (Glint handles these)
            local ft = vim.bo[bufnr].filetype
            if ft == 'typescript.glimmer' or ft == 'javascript.glimmer' then
              client.stop()
            end
          end,
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'bashls',
        'clangd',
        'eslint-lsp',
        'gopls',
        'html',
        'jsonls',
        'pyright',
        'stylua',
        'ruby_lsp',
        'ts_ls',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            -- Skip stylua - it's a formatter, not an LSP server
            if server_name == 'stylua' then
              return
            end
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      -- Glint LSP for Ember/Glimmer (.gts/.gjs) — not Mason-managed,
      -- requires @glint/core installed in the project
      vim.lsp.config('glint', {
        cmd = { 'glint-language-server' },
        filetypes = { 'handlebars', 'typescript.glimmer', 'javascript.glimmer' },
        root_markers = { 'ember-cli-build.js', '.glintrc.yml', '.glintrc', '.glintrc.json' },
        capabilities = capabilities,
      })
      vim.lsp.enable('glint')
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
