-- KEYMAPS
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Remove highlighted search' })
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', 'zF', 'f{v%zf', { desc = 'Fold function block when cursor is on the method signature (or any {} block)})'})

-- i'm going to get fired for these
vim.keymap.set('n', '<leader>q', vim.cmd.q, { desc = 'Finally figured it out' })
vim.keymap.set('n', '<leader>w', vim.cmd.w, { desc = 'Write file' })

vim.keymap.set("n", "<leader>cs", "<cmd>Telescope colorscheme<CR>")
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>")

-- Golang laziness
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function(event)
    vim.keymap.set("i", "::", ":=", { buffer = event.buf, desc = "Walrus Operator" })
    vim.keymap.set('n', '<leader>gtj', "<cmd>GoTagAdd json<CR>", { buffer = event.buf, desc = "Add JSON struct tags" })
    vim.keymap.set('n', '<leader>ee', "<cmd>GoIfErr<CR>", { buffer = event.buf, desc = "Handle those errors" })
    vim.keymap.set('n', '<leader>gta', "<cmd>GoTestAdd<CR>", { buffer = event.buf, desc = "Handle those errors" })
  end,
})

-- Lsp
vim.keymap.set('n', '<leader>li', "<cmd>LspInfo<CR>", { desc = "Get LSP info" })
vim.keymap.set('n', '<leader>lr', "<cmd>LspRestart<CR>", { desc = "Restart LSP" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [d]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [d]iagnostic message' })
vim.keymap.set('n', '<leader>d', vim.lsp.buf.code_action, { desc = 'Show available code actions' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [e]rror messages' })
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- I'm scared of the blackhole register
vim.keymap.set('v', 'p', '"_dp', { desc = 'Always delete to blackhole register when pasting' })
vim.keymap.set('n', 'J', '5j')
vim.keymap.set('n', 'K', '5k')
vim.keymap.set('n', '<leader>o', 'o<Esc>', { desc = 'Insert new line below. Stay in normal mode' })
vim.keymap.set('n', '<leader>O', 'O<Esc>', { desc = 'Insert new line above. Stay in normal mode' })

-- move highlighted text
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = "Move highlighted lines up" })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = "Move highlighted lines down" })

-- project navigation
vim.keymap.set('n', '<leader>ft', vim.cmd.NvimTreeToggle, { desc = 'View [f]ile [t]ree' })
vim.keymap.set('n', '<leader>cn', ':cnext<CR>', { desc = 'Next item on quickfix list' })
vim.keymap.set('n', '<leader>cp', ':cprev<CR>', { desc = 'Previous item on quickfix list' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the above window' })

-- terminal
vim.keymap.set('n', '<leader>x', ':!chmod +x %<CR>', { desc = 'Make current file e[x]ecutable' })
