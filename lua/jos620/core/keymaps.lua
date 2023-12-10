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

-- Telescope
M.set("n", "<Leader>ff", ":Telescope find_files<Return>", "Find files")
M.set("n", "<Leader>fa", ":Telescope find_files hidden=true<Return>", "Find all files")
M.set("n", "<Leader>fs", ":Telescope live_grep<Return>", "Search in files")
M.set("n", "<Leader>fb", ":Telescope buffers<Return>", "Find buffers")
M.set("n", "<Leader>fo", ":Telescope oldfiles<Return>", "Find recent files")
M.set("n", "<Leader>fk", ":Telescope keymaps<Return>", "Find keymaps")
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

--- Setup LSP keymaps
---@param buffer number
function M.setup_lsp_keymaps(buffer)
  local opts = { noremap = true, silent = true, buffer = buffer }

  M.set("n", "K", ":Lspsaga hover_doc<Return>", "Show hover doc", opts)

  M.set("n", "gf", ":Lspsaga finder<Return>", "Find definition", opts)
  M.set("n", "gd", ":Lspsaga goto_definition<Return>", "Go to definition", opts)
  M.set("n", "gD", ":Lspsaga peek_definition<Return>", "Peek definition", opts)
  M.set("n", "gi", ":lua vim.lsp.buf.implementation()<Return>", "Go to implementation", opts)

  M.set("n", "<Leader>lf", ":Lspsaga lsp_finder<Return>", "Find references", opts)
  M.set("n", "<Leader>la", ":Lspsaga code_action<Return>", "Code action", opts)
  M.set("n", "<Leader>lr", ":Lspsaga rename<Return>", "Rename symbol", opts)
  M.set("n", "<Leader>ld", ":Lspsaga show_line_diagnostics<Return>", "Show line diagnostics", opts)
  M.set("n", "<Leader>lc", ":Lspsaga show_cursor_diagnostics<Return>", "Show cursor diagnostics", opts)
  M.set("n", "<Leader>lb", ":Lspsaga show_buf_diagnostics<Return>", "Show buffer diagnostics", opts)
  M.set("n", "<Leader>lw", ":Lspsaga show_workspace_diagnostics<Return>", "Show workspace diagnostics", opts)

  local diagnostic_status, diagnostic = pcall(require, "lspsaga.diagnostic")
  if diagnostic_status then
    M.set("n", "<Leader>lj", function()
      diagnostic:goto_next()
    end, "Jump to next diagnostic", opts)

    M.set("n", "<Leader>lk", function()
      diagnostic:goto_prev()
    end, "Jump to previous diagnostic", opts)
  end
end

--- Setup formatting keymaps
---@param conform any
function M.setup_formatting_keymaps(conform)
  M.set({ "n", "v" }, "<Leader>lF", function()
    conform.format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    })
  end, "Format file or range")
end

--- Setup linting keymaps
---@param lint any
function M.setup_linting_keymaps(lint)
  M.set("n", "<Leader>lL", function()
    lint.try_lint()
  end, "Lint file")
end

return M
