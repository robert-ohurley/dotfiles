-- Save and Close --
vim.keymap.set('n', '<leader>wq', '<cmd>wqa<CR>', { desc = '[W]rite and [Quit] [All] Files' })
vim.keymap.set('n', '<leader>wa', '<cmd>wall<CR>', { desc = '[W]rite [All] Files' })
vim.keymap.set('n', '<leader>wf', '<cmd>w<CR>', { desc = '[W]rite [File]' })
vim.keymap.set('n', '<leader>qa', '<cmd>qa!<CR>', { desc = '[Quit] [A]ll [F]iles' })
vim.keymap.set('n', '<leader>qf', '<cmd>q!<CR>', { desc = '[Quit] [F]iles' })

-- Yank, Delete, Paste --
vim.keymap.set('n', '<leader>pa', 'ggVGp', { desc = 'Select and [P]aste over [A]ll' })
vim.keymap.set('n', '<leader>sa', 'ggVG', { desc = '[S]elect [A]ll' })
vim.keymap.set('n', '<leader>da', 'ggVGd', { desc = '[D]elete [A]ll' })
vim.keymap.set('n', '<leader>ya', 'ggVGy', { desc = '[Y]ank [A]ll' })
vim.keymap.set('i', '<C-p>', '<Esc>p', { desc = 'Paste in insert mode' })
vim.keymap.set('v', 'p', '"_dp', { desc = 'Always delete to blackhole register when pasting' })

-- Debugger --
vim.keymap.set('n', '<leader>db', '<cmd> DapToggleBreakpoint <CR>', { desc = 'Add [d]ebugger [b]reakpoint' })
vim.keymap.set('n', '<leader>dr', '<cmd> DapContinue <CR>', { desc = '[d]ebugger [r]un' })

-- Misc --
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Remove highlighted search' })
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<leader>cs', '<cmd>Telescope colorscheme<CR>')
vim.keymap.set('n', '<leader>fm', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<CR>')
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move highlighted lines up' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move highlighted lines down' })
vim.keymap.set('n', '<leader>o', 'o<Esc>', { desc = 'Insert new line below. Stay in normal mode' })
vim.keymap.set('n', '<leader>O', 'O<Esc>', { desc = 'Insert new line above. Stay in normal mode' })
vim.keymap.set('n', '<leader>il', 'O<Esc>jo<Esc>k', { desc = '[I]nsert [L]ines above and below' })
vim.keymap.set('n', 'J', '5j')
vim.keymap.set('n', 'K', '5k')

-- Folds --
vim.keymap.set('n', 'zF', 'f{v%zf', { desc = 'Fold function block when cursor is on the method signature (or any {} block)})' })

-- Golang --
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go' },
  callback = function(event)
    vim.keymap.set('i', '::', ':=', { buffer = event.buf, desc = 'Walrus Operator' })
    vim.keymap.set('n', '<leader>gtj', '<cmd>GoTagAdd json<CR>', { buffer = event.buf, desc = 'Add JSON struct tags' })
    vim.keymap.set('n', '<leader>ee', '<cmd>GoIfErr<CR>', { buffer = event.buf, desc = 'Handle those errors' })
    vim.keymap.set('n', '<leader>gta', '<cmd>GoTestAdd<CR>', { buffer = event.buf, desc = 'Create test' })
  end,
})

-- LSP --
vim.keymap.set('n', '<leader>li', '<cmd>LspInfo<CR>', { desc = 'Get LSP info' })
vim.keymap.set('n', '<leader>lr', '<cmd>LspRestart<CR>', { desc = 'Restart LSP' })

-- Diagnostic Keymaps --
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [d]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [d]iagnostic message' })
vim.keymap.set('n', '<leader>d', vim.lsp.buf.code_action, { desc = 'Show available code actions' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [e]rror messages' })
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Project Navigation --
vim.keymap.set('n', '<leader>ft', vim.cmd.NvimTreeToggle, { desc = 'View [f]ile [t]ree' })
vim.keymap.set('n', '<leader>cn', ':cnext<CR>', { desc = 'Next item on quickfix list' })
vim.keymap.set('n', '<leader>cp', ':cprev<CR>', { desc = 'Previous item on quickfix list' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the above window' })

-- Terminal
vim.keymap.set('n', '<leader>x', ':!chmod +x %<CR>', { desc = 'Make current file e[x]ecutable' })
