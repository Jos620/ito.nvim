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

-- Search settings
o.ignorecase = true
o.smartcase = true

-- Cursor line
o.cursorline = true

-- Appearence
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
o.scrolloff = 8
o.sidescrolloff = 8

-- Update the file when it changes
o.autoread = true

-- Hide the mode from the status line
o.showmode = false

-- Set ruler
o.ruler = false

-- Set last status
o.laststatus = 0
