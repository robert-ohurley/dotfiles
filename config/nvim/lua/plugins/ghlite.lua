return  {
    'daliusd/ghlite.nvim',
    config = function()
      require('ghlite').setup({
        debug = false, -- if set to true debugging information is written to ~/.ghlite.log file
        view_split = 'vsplit', -- set to empty string '' to open in active buffer, use 'tabnew' to open in tab
        diff_split = 'vsplit', -- set to empty string '' to open in active buffer, use 'tabnew' to open in tab
        comment_split = 'split', -- set to empty string '' to open in active buffer, use 'tabnew' to open in tab
        open_command = 'open', -- open command to use, e.g. on Linux you might want to use xdg-open
        merge = {
          approved = '--squash',
          nonapproved = '--auto --squash',
        },
        html_comments_command = { 'lynx', '-stdin', '-dump' }, -- command to render HTML comments in PR view
        -- override default keymaps with the ones you prefer
        -- set keymap to false or '' to disable it
        keymaps = {
          diff = {
            open_file = 'gf',
            open_file_tab = '',
            open_file_split = 'o',
            open_file_vsplit = 'O',
            approve = 'cA',
            request_changes = 'cR',
          },
          comment = {
            send_comment = 'c<CR>' -- this one cannot be disabled
          },
          pr = {
            approve = 'cA',
            request_changes = 'cR',
            merge = 'cM',
            comment = 'ca',
            diff = 'cp',
          },
        },
      })
    end,
    keys = {
      { '<leader>gp', ':GHLitePRSelect<cr>',        silent = true, desc = 'PR Select' },
      { '<leader>gv', ':GHLitePRView<cr>',          silent = true, desc = 'PR View' },
      { '<leader>gd', ':GHLitePRDiff<cr>',          silent = true, desc = 'PR Diff' },
      { '<leader>gl', ':GHLitePRDiffview<cr>',      silent = true, desc = 'PR Diffview' },
      { '<leader>gc', ':GHLitePRCheckout<cr>',      silent = true, desc = 'PR Checkout' },
      { '<leader>gu', ':GHLitePRLoadComments<cr>',  silent = true, desc = 'PR Load Comments' },
    }
  } 
