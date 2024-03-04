local utils = require("jos620.utils")

-- Exit insert mode
utils.SetKeymap("i", "jk", "<Esc>", "Exit insert mode")

-- Scroll
utils.SetKeymap("n", "zl", "30zl", "Scroll right")
utils.SetKeymap("n", "zh", "30zh", "Scroll left")

-- Do not yank with "X" and "P"
utils.SetKeymap({ "n", "v" }, "x", '"_x', "Do not yank with 'x'")
utils.SetKeymap({ "n", "v" }, "X", '"_X', "Do not yank with 'X'")
utils.SetKeymap("x", "p", '"_dP', "Do not yank with 'p'")

-- Move lines with visual
utils.SetKeymap("v", "J", ":m '>+1<Return>gv=gv", "Move lines down")
utils.SetKeymap("v", "K", ":m '<-2<Return>gv=gv", "Move lines up")

-- "ie" for "all file"
utils.SetKeymap("n", "vie", "ggVG", "Select all file")
utils.SetKeymap("n", "cie", "ggcG", "Change all file")
utils.SetKeymap("n", "die", "ggdG", "Delete all file")
utils.SetKeymap("n", "yie", "ggVGy", "Yank all file")

-- Better navigation on wrapped lines
utils.SetKeymap("n", "j", "gj", "Move down")
utils.SetKeymap("n", "k", "gk", "Move up")

-- Line indent with visual
utils.SetKeymap("v", ">", ">gv", "Indent lines")
utils.SetKeymap("v", "<", "<gv", "Unindent lines")

-- Split window
utils.SetKeymap("n", "<Leader>sv", "<C-w>v", "Split window vertically")
utils.SetKeymap("n", "<Leader>sb", "<C-w>s", "Split window horizontally")
utils.SetKeymap("n", "<Leader>se", "<C-w>=", "Equalize windows")

utils.SetKeymap("n", "<Leader>%", function()
  vim.cmd("only")
  utils.CloseEmptyBuffers()
end, "Close other windows")
utils.SetKeymap("n", "<Leader>q", ":quit<Return>", "Quit window")
utils.SetKeymap("n", "<Leader>x", ":close<Return>", "Close window")

utils.SetKeymap("n", "<Leader>Sv", "<C-w>t<C-w>H", "Change split orientation to horizontal")
utils.SetKeymap("n", "<Leader>Sb", "<C-w>t<C-w>K", "Change split orientation to vertical")

-- Fold keymaps
utils.SetKeymap("n", "<Leader>z", "$V%zf", "Create fold")

-- Increase / decrease
utils.SetKeymap("n", "=", "<C-a>", "Increase")
utils.SetKeymap("n", "-", "<C-x>", "Decrease")

-- Buffers
utils.SetKeymap("n", "<Leader>c", ":bdelete<Return>", "Close buffer")
utils.SetKeymap("n", "<Leader>C", ":b# <bar> bd#<Return>", "Close buffer, without closing the window")

-- Git
utils.SetKeymap("n", "gh", ":diffget //2<Return>", "Use left diff hunk")
utils.SetKeymap("n", "gl", ":diffget //3<Return>", "Use right diff hunk")
