--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- use for talon to detect the window
vim.opt.title = true
-- Use file type to determine specific voice commands
-- Use 'neovim' For neovim specific voice mappings
vim.opt.titlestring = [[nvim - %t]]
vim.opt.tabline = ""

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.guicursor = 'n-v-i-c:block'

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

--Previous folding config
-- function _G.CustomFoldText()
--   return vim.fn.getline(vim.v.foldstart) .. ' ... ' .. vim.fn.getline(vim.v.foldend):gsub('^%s*', '')
-- end

-- vim.opt.foldtext = 'v:lua.CustomFoldText()'
-- vim.opt.foldmethod = 'manual'
-- vim.opt.foldlevel = 99

-- Change this to true if you know you have a Nerd Font
local USE_NERD_FONT = false

-- pick an icon with fallback
local function fold_icon()
  if USE_NERD_FONT then
    return ""  -- or "󰁂" / "" etc.
  end
  return ""     -- plain ASCII-ish fallback
end

function _G.custom_fold_text()
  local start  = vim.v.foldstart
  local finish = vim.v.foldend
  local line   = vim.fn.getline(start)

  -- capture indentation separately
  local indent = line:match("^(%s*)") or ""
  local first  = line:gsub("^%s+", ""):gsub("%s+$", "")

  local lines  = finish - start + 1
  local suffix = ("  ↧ %d lines "):format(lines)

  local win_w    = vim.api.nvim_win_get_width(0)
  local suffix_w = vim.fn.strdisplaywidth(suffix)
  local indent_w = vim.fn.strdisplaywidth(indent)
  local first_w  = vim.fn.strdisplaywidth(first)

  -- space available for first part after indent + suffix
  local max_first_w = math.max(1, win_w - indent_w - suffix_w - 1)

  if first_w > max_first_w then
    local cut_to = math.max(1, max_first_w - 1)
    local idx, acc = 1, 0
    while idx <= #first and acc < cut_to do
      local ch = first:sub(idx, idx)
      local w = vim.fn.strdisplaywidth(ch)
      if acc + w > cut_to then break end
      acc = acc + w
      idx = idx + 1
    end
    first = first:sub(1, idx - 1) .. "…"
    first_w = vim.fn.strdisplaywidth(first)
  end

  -- padding between first part and suffix
  local pad = math.max(1, win_w - indent_w - first_w - suffix_w)
  return indent .. first .. string.rep(" ", pad) .. suffix
end

vim.opt.foldtext = "v:lua.custom_fold_text()"

-- optional: make folds look nicer in the gutter
vim.opt.fillchars:append({ fold = " ", foldopen = "", foldclose = "", foldsep = " " })

vim.opt.foldmethod = "expr"
vim.opt.foldexpr   = "v:lua.vim.treesitter.foldexpr()"

vim.opt.foldenable = true
vim.opt.foldlevel  = 99
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "1"           -- gutter showing folds idk about this yet
vim.opt.foldtext = "v:lua.custom_fold_text()"

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.swapfile = false

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
-- vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

vim.opt.timeoutlen = 1000

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
