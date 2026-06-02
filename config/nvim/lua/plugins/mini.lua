return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      require('mini.comment').setup {
        options = {
          ignore_blank_line = true,
          custom_commentstring = function()
            if vim.bo.filetype == 'vue' then
              return '<!-- %s -->'
            else
              return vim.bo.commentstring
            end
          end,
        },
        mappings = {
          comment = 'gc',
          comment_line = 'gcc',
          comment_visual = 'gc',
          -- Define 'comment' textobject (like `dgc` - delete whole comment block)
          textobject = 'gc',
        },
      }

      -- -- Simple and easy statusline.
      local statusline = require 'mini.statusline'
      -- Default layout (filename left-aligned). The section overrides below
      -- drop git/diff/lsp/size/location, so the bar stays minimal.
      statusline.setup { use_icons = vim.g.have_nerd_font }
      -- No line:char location section.
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return ''
      end

      -- File info without the file size (keep filetype + encoding).
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_fileinfo = function(args)
        local ft = vim.bo.filetype
        if ft == '' then
          return ''
        end
        if statusline.is_truncated(args.trunc_width) then
          return ft
        end
        local enc = vim.bo.fileencoding ~= '' and vim.bo.fileencoding or vim.bo.encoding
        return string.format('%s %s', ft, enc)
      end

      -- No LSP server name in the statusline.
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_lsp = function()
        return ''
      end

      -- No git branch in the statusline.
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_git = function()
        return ''
      end

      -- No git diff (+/~/-) section or its icon.
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_diff = function()
        return ''
      end

      -- Diagnostics as full words ("Errors: 3  Warnings: 1") instead of E/W/I/H.
      -- Only non-zero levels are shown.
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_diagnostics = function(args)
        if statusline.is_truncated(args.trunc_width) then
          return ''
        end
        local S = vim.diagnostic.severity
        local counts = vim.diagnostic.count(0)
        local labels = {
          { S.ERROR, 'Errors' },
          { S.WARN, 'Warnings' },
          { S.INFO, 'Info' },
          { S.HINT, 'Hints' },
        }
        local parts = {}
        for _, l in ipairs(labels) do
          local n = counts[l[1]] or 0
          if n > 0 then
            table.insert(parts, string.format('%s: %d', l[2], n))
          end
        end
        return table.concat(parts, '  ')
      end
    end,
  },
}
