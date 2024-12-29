return { -- Autoformat
  'stevearc/conform.nvim',
  event = 'BufEnter',
  lazy = false,
  keys = {
    {
      '<leader>fm',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[f]or[m]at buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      -- Run multiple formatters sequentially
      go = { 'goimports', 'gofmt' },
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      sql = { 'sql-formatter' },
      -- javascript = { 'prettier' },
      -- The "*" filetype runs formatters on all filetypes.
      ['*'] = { 'codespell' },
      -- The "_" filetype runs formatters on filetypes that don't have other formatters configured.
      ['_'] = { 'trim_whitespace' },
    },
    notify_no_formatters = true,
  },
}
