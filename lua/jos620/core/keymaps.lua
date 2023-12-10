local utils = require("jos620.utils")

local M = {}

-- Alias for vim.api.nvim_set_keymap
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

-- Clear screen
M.set("n", "<Leader>h", function()
  vim.cmd([[nohlsearch]])
  vim.cmd([[echom '']])

  local notify_status, notify = pcall(require, "notify")
  if notify_status then
    notify.dismiss()
  end
end, "Clear screen")

-- Navigation
M.set("n", "f", "<Plug>Sneak_f")
M.set("n", "F", "<Plug>Sneak_F")

-- Scroll
M.set("n", "zl", "30zl", "Scroll right")
M.set("n", "zh", "30zh", "Scroll left")

-- Do not yank with "X", "P" and "cc"
M.set({ "n", "v" }, "x", '"_x', "Do not yank with 'x'")
M.set({ "n", "v" }, "X", '"_X', "Do not yank with 'X'")
M.set("n", "cc", '"_cc', "Do not yank with 'cc'")
M.set("x", "p", '"_dP', "Do not yank with 'p'")

-- Move lines with visual
M.set("v", "J", ":m '>+1<Return>gv=gv", "Move lines down")
M.set("v", "K", ":m '<-2<Return>gv=gv", "Move lines up")

-- "ie" as file
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
M.set("n", "<Leader>sm", ":MaximizerToggle<Return>", "Maximize window")

M.set("n", "<Leader>%", "<C-w>o", "Close other windows")
M.set("n", "<Leader>q", ":quit<Return>", "Quit window")
M.set("n", "<Leader>x", ":close<Return>", "Close window")

M.set("n", "<Leader>Sv", "<C-w>t<C-w>H", "Change split orientation to horizontal")
M.set("n", "<Leader>Sb", "<C-w>t<C-w>K", "Change split orientation to vertical")

--- Fold keymaps
M.set("n", "<Leader>z", "$V%zf", "Create fold")

-- Increase / decrease
M.set("n", "=", "<C-a>", "Increase")
M.set("n", "-", "<C-x>", "Decrease")

-- File tree
M.set("n", "<Leader>o", ":Oil<Return>", "Toggle Oil")
M.set("n", "<Leader>O", ":vsplit<Return>:Oil<Return>", "Open oil nvim")

M.set("n", "<Leader>u", ":UndotreeToggle<Return>", "Toggle Undo Tree")
M.set("n", "<Leader>U", ":UndotreeFocus<Return>", "Focus Undo Tree")

-- Buffers
M.set("n", "H", ":BufferLineCyclePrev<Return>", "Previous buffer")
M.set("n", "L", ":BufferLineCycleNext<Return>", "Next buffer")
M.set("n", "<Leader>,", ":BufferLineMovePrev<Return>", "Move buffer left")
M.set("n", "<Leader>.", ":BufferLineMoveNext<Return>", "Move buffer right")
M.set("n", "<Leader>c", ":bdelete<Return>", "Close buffer")
M.set("n", "<Leader>C", ":b# <bar> bd#<Return>", "Close buffer, without closing the window")

-- Packages
M.set("n", "<Leader>mm", ":Mason<Return>", "Launch Mason")

-- Git
M.set("n", "gs", ":vertical rightbelow Git<Return>", "Open git status")
M.set("n", "gh", ":diffget //2<Return>", "Use left diff hunk")
M.set("n", "gm", ":GitMessenger<Return>", "Open git messenger")
M.set("n", "gl", ":diffget //3<Return>", "Use right diff hunk")
M.set("n", "gL", ":LazyGit<Return>", "Open lazy git")

return M
