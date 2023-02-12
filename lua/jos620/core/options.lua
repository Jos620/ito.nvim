local opt = vim.opt

-- Leader key
vim.g.mapleader = " "

-- Numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor line
opt.cursorline = true

-- Appearence
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split
opt.splitright = true
opt.splitbelow = true

-- Scroll
opt.scrolloff = 12
opt.sidescrolloff = 8

-- Update the file when it changes
opt.autoread = true
