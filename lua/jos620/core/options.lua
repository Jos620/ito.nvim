local o = vim.opt
local g = vim.g

-- Leader key
g.mapleader = " "

-- Numbers
o.number = true
o.relativenumber = true

-- Tabs & indentation
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.autoindent = true

-- Line wrapping
o.wrap = false

-- Save files
o.swapfile = false
o.backup = false
o.undodir = vim.fn.stdpath("config") .. "/undodir"
o.undofile = true

-- Search settings
o.ignorecase = true
o.smartcase = true
o.hlsearch = false
o.incsearch = true

-- Cursor line
o.cursorline = true

-- Appearance
o.termguicolors = true
o.background = "dark"
o.signcolumn = "yes"

-- Backspace
o.backspace = "indent,eol,start"

-- Clipboard
o.clipboard:append("unnamedplus")

-- Split
o.splitright = true
o.splitbelow = true

-- Scroll
o.scrolloff = 5
o.sidescrolloff = 5

-- Update the file when it changes
o.autoread = true

-- Bottom bar
o.showmode = false
o.ruler = false

-- Set cursor as block
o.guicursor = "n-v-c:block,i-ci-ve:block"

-- Set global statusline
o.laststatus = 3

-- Mouse support
o.mouse = "a"

-- Fold
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true
