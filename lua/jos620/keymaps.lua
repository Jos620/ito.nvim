local utils = require("jos620.utils")

-- Exit insert mode
utils.set_keymap("i", "jk", "<Esc>", "Exit insert mode")

-- Scroll
utils.set_keymap("n", "zl", "30zl", "Scroll right")
utils.set_keymap("n", "zh", "30zh", "Scroll left")

-- Do not yank with "X" and "P"
utils.set_keymap({ "n", "v" }, "x", '"_x', "Do not yank with 'x'")
utils.set_keymap({ "n", "v" }, "X", '"_X', "Do not yank with 'X'")
utils.set_keymap("x", "p", '"_dP', "Do not yank with 'p'")

-- Move lines with visual
utils.set_keymap("v", "J", ":m '>+1<Return>gv=gv", "Move lines down")
utils.set_keymap("v", "K", ":m '<-2<Return>gv=gv", "Move lines up")

-- "ie" for "all file"
utils.set_keymap("n", "vie", "ggVG", "Select all file")
utils.set_keymap("n", "cie", "ggcG", "Change all file")
utils.set_keymap("n", "die", "ggdG", "Delete all file")
utils.set_keymap("n", "yie", "ggVGy", "Yank all file")

-- Better navigation on wrapped lines
utils.set_keymap("n", "j", "gj", "Move down")
utils.set_keymap("n", "k", "gk", "Move up")

-- Line indent with visual
utils.set_keymap("v", ">", ">gv", "Indent lines")
utils.set_keymap("v", "<", "<gv", "Unindent lines")

-- Split window
utils.set_keymap("n", "<Leader>sv", "<C-w>v", "Split window vertically")
utils.set_keymap("n", "<Leader>sb", "<C-w>s", "Split window horizontally")
utils.set_keymap("n", "<Leader>se", "<C-w>=", "Equalize windows")

utils.set_keymap("n", "<Leader>%", function()
  vim.cmd("only")
end, "Close other windows")
utils.set_keymap("n", "<Leader>q", ":quit<Return>", "Quit window")
utils.set_keymap("n", "<Leader>x", ":close<Return>", "Close window")

utils.set_keymap("n", "<Leader>Sv", "<C-w>t<C-w>H", "Change split orientation to horizontal")
utils.set_keymap("n", "<Leader>Sb", "<C-w>t<C-w>K", "Change split orientation to vertical")

-- Fold keymaps
utils.set_keymap("n", "<Leader>z", "$V%zf", "Create fold")

-- Increase / decrease
utils.set_keymap("n", "=", "<C-a>", "Increase")
utils.set_keymap("n", "-", "<C-x>", "Decrease")

-- Buffers
utils.set_keymap("n", "<Leader>c", ":bdelete<Return>", "Close buffer")
utils.set_keymap("n", "<Leader>C", ":b# <bar> bd#<Return>", "Close buffer, without closing the window")

-- Git
utils.set_keymap("n", "gh", ":diffget //2<Return>", "Use left diff hunk")
utils.set_keymap("n", "gl", ":diffget //3<Return>", "Use right diff hunk")
