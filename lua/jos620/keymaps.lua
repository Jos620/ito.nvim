local utils = require("jos620.utils")

local M = {}

---Alias for vim.api.nvim_set_keymap
---@param mode string|string[]
---@param key string
---@param command string|function
---@param desc? string
---@param options? KeymapSetOptions
function M.set(mode, key, command, desc, options)
  local opts = options or { silent = true }
  vim.keymap.set(mode, key, command, utils.MergeTables({ opts, { desc = desc } }))
end

-- Exit insert mode
M.set("i", "jk", "<Esc>", "Exit insert mode")

-- Scroll
M.set("n", "zl", "30zl", "Scroll right")
M.set("n", "zh", "30zh", "Scroll left")

-- Do not yank with "X" and "P"
M.set({ "n", "v" }, "x", '"_x', "Do not yank with 'x'")
M.set({ "n", "v" }, "X", '"_X', "Do not yank with 'X'")
M.set("x", "p", '"_dP', "Do not yank with 'p'")

-- Move lines with visual
M.set("v", "J", ":m '>+1<Return>gv=gv", "Move lines down")
M.set("v", "K", ":m '<-2<Return>gv=gv", "Move lines up")

-- "ie" for "all file"
M.set("n", "vie", "ggVG", "Select all file")
M.set("n", "cie", "ggcG", "Change all file")
M.set("n", "die", "ggdG", "Delete all file")
M.set("n", "yie", "ggVGy", "Yank all file")

-- Better navigation on wrapped lines
M.set("n", "j", "gj", "Move down")
M.set("n", "k", "gk", "Move up")

-- Line indent with visual
M.set("v", ">", ">gv", "Indent lines")
M.set("v", "<", "<gv", "Unindent lines")

-- Split window
M.set("n", "<Leader>sv", "<C-w>v", "Split window vertically")
M.set("n", "<Leader>sb", "<C-w>s", "Split window horizontally")
M.set("n", "<Leader>se", "<C-w>=", "Equalize windows")

M.set("n", "<Leader>%", function()
  vim.cmd("only")
  utils.CloseEmptyBuffers()
end, "Close other windows")
M.set("n", "<Leader>q", ":quit<Return>", "Quit window")
M.set("n", "<Leader>x", ":close<Return>", "Close window")

M.set("n", "<Leader>Sv", "<C-w>t<C-w>H", "Change split orientation to horizontal")
M.set("n", "<Leader>Sb", "<C-w>t<C-w>K", "Change split orientation to vertical")

-- Fold keymaps
M.set("n", "<Leader>z", "$V%zf", "Create fold")

-- Increase / decrease
M.set("n", "=", "<C-a>", "Increase")
M.set("n", "-", "<C-x>", "Decrease")

-- Buffers
M.set("n", "<Leader>c", ":bdelete<Return>", "Close buffer")
M.set("n", "<Leader>C", ":b# <bar> bd#<Return>", "Close buffer, without closing the window")

-- Git
M.set("n", "gh", ":diffget //2<Return>", "Use left diff hunk")
M.set("n", "gl", ":diffget //3<Return>", "Use right diff hunk")

return M
