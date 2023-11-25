vim.g.mapleader = " "

--better escapes
vim.keymap.set("t", "jk", "<C-\\><C-n>")
vim.keymap.set("i", "jk", "<ESC>")

--faster up/down movement
vim.keymap.set("n", "<S-j>", "5j")
vim.keymap.set("n", "<S-k>", "5k")

--quick actions to beginning and end of lines
vim.keymap.set("n", "ds", "d^")
vim.keymap.set("n", "de", "dg_")
vim.keymap.set("n", "ys", "y^")
vim.keymap.set("n", "ye", "yg")
vim.keymap.set("n", "<leader>s", "^")
vim.keymap.set("n", "<leader>e", "g_")

--insert new lines without leaving normal mode
vim.keymap.set("n", "<leader>o", "o<ESC>")
vim.keymap.set("n", "<leader>O", "O<ESC>")

-- file actions
vim.keymap.set("n", "<leader>w", vim.cmd.write)
--vim.keymap.set("n", "<leader>q", vim.cmd.quit)
vim.keymap.set("n", "<leader>q", vim.cmd.bd)

--better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move selected line / block of text in visual mode
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv")
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv")

--enter command mode with semi-colon
vim.keymap.set("n", ";", ":")
vim.keymap.set("v", ";", ":")

--faster find and replace
vim.keymap.set("n", "<leader>rep", ":%s/")

--copy to system clipboard
vim.keymap.set("v", "<leader>y", '"*y')



--TreeSitter Remaps
vim.keymap.set("n", "<leader>tsi", ':TSInstall ')

--Source init.lua
vim.keymap.set("n", "<leader>so", ':luafile %')
