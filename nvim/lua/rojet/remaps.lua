-- KEYMAPS
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', 'jk', '<Esc>')

-- literally the most dumbest remap ever -- when creating a new func  
-- will position the cursor inside the parenthesis no matter what
vim.keymap.set('i', '<C-]>', '<Esc>?{<CR><Esc>da}a{<CR>}<Esc>ko')

-- Oof, v important for go, bad for anything else --
vim.keymap.set('i', '::', ':=')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- I'm scared of the blackhole register
vim.keymap.set('v', '<leader>p', '"_dp', { desc = 'Delete to blackhole register when pasting' })
vim.keymap.set('v', '<leader>P', '"_dP', { desc = 'Delete to blackhole register when pasting' })

-- faster up/down navigation
vim.keymap.set('n', 'J', '5j')
vim.keymap.set('n', 'K', '5k')
vim.keymap.set('n', '<leader>o', 'o<Esc>', { desc = 'Insert new line below. Stay in normal mode' })
vim.keymap.set('n', '<leader>O', 'O<Esc>', { desc = 'Insert new line above. Stay in normal mode' })

-- centre searching
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- move highlighted text
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- project view
vim.keymap.set('n', '<leader>ft', vim.cmd.Ex, { desc = 'View [f]ile [t]ree' })
vim.keymap.set('n', '<leader>cn', ':cnext<CR>', { desc = 'Next item on quickfix list' })
vim.keymap.set('n', '<leader>cp', ':cprev<CR>', { desc = 'Previous item on quickfix list' })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the above window' })
