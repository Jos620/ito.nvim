local utils = require("jos620.utils")

local M = {}

-- Alias for vim.api.nvim_set_keymap
---@param mode string|string[]
---@param key string
---@param command string|function
---@param desc? string
---@param options? KeymapSetOptions
local function set(mode, key, command, desc, options)
  local opts = options or { silent = true }
  vim.keymap.set(mode, key, command, utils.MergeTables({ opts, { desc = desc } }))
end

-- Exit insert mode
set("i", "jk", "<Esc>", "Exit insert mode")

-- Clear screen
set("n", "<Leader>h", function()
  vim.cmd([[nohlsearch]])
  vim.cmd([[echom '']])

  local notify_status, notify = pcall(require, "notify")
  if notify_status then
    notify.dismiss()
  end
end, "Clear screen")

-- Navigation
set("n", "f", "<Plug>Sneak_f")
set("n", "F", "<Plug>Sneak_F")

-- Scroll
set("n", "zl", "30zl", "Scroll right")
set("n", "zh", "30zh", "Scroll left")

-- Do not yank with "X", "P" and "cc"
set({ "n", "v" }, "x", '"_x', "Do not yank with 'x'")
set({ "n", "v" }, "X", '"_X', "Do not yank with 'X'")
set("n", "cc", '"_cc', "Do not yank with 'cc'")
set("x", "p", '"_dP', "Do not yank with 'p'")

-- Move lines with visual
set("v", "J", ":m '>+1<Return>gv=gv", "Move lines down")
set("v", "K", ":m '<-2<Return>gv=gv", "Move lines up")

-- "ie" as file
set("n", "vie", "ggVG", "Select all file")
set("n", "cie", "ggcG", "Change all file")
set("n", "die", "ggdG", "Delete all file")
set("n", "yie", "ggVGy", "Yank all file")

-- Better navigation on wrapped lines
set("n", "j", "gj", "Move down")
set("n", "k", "gk", "Move up")

-- Line indent with visual
set("v", ">", ">gv", "Indent lines")
set("v", "<", "<gv", "Unindent lines")

-- Split window
set("n", "<Leader>sv", "<C-w>v", "Split window vertically")
set("n", "<Leader>sb", "<C-w>s", "Split window horizontally")
set("n", "<Leader>se", "<C-w>=", "Equalize windows")
set("n", "<Leader>sm", ":MaximizerToggle<Return>", "Maximize window")

set("n", "<Leader>%", "<C-w>o", "Close other windows")
set("n", "<Leader>q", ":quit<Return>", "Quit window")
set("n", "<Leader>x", ":close<Return>", "Close window")

set("n", "<Leader>Sv", "<C-w>t<C-w>H", "Change split orientation to horizontal")
set("n", "<Leader>Sb", "<C-w>t<C-w>K", "Change split orientation to vertical")

--- Setup fold keymaps
set("n", "<Leader>z", "$V%zf", "Create fold")

-- Increase / decrease
set("n", "=", "<C-a>", "Increase")
set("n", "-", "<C-x>", "Decrease")

-- File tree
set("n", "<Leader>o", ":Oil<Return>", "Toggle Oil")
set("n", "<Leader>O", ":vsplit<Return>:Oil<Return>", "Open oil nvim")

set("n", "<Leader>u", ":UndotreeToggle<Return>", "Toggle Undo Tree")
set("n", "<Leader>U", ":UndotreeFocus<Return>", "Focus Undo Tree")

--- Setup Harpoon keymaps
function M.setup_harpoon_keymaps()
  local harpoon_status, _ = pcall(require, "harpoon")
  if not harpoon_status then
    return
  end

  local mark = require("harpoon.mark")
  local ui = require("harpoon.ui")

  set("n", "<Leader>\\", function()
    mark.add_file()
    ui.toggle_quick_menu()
  end, "Add file to harpoon")

  set("n", "<Leader>|", ui.toggle_quick_menu, "Toggle harpoon menu")

  for i = 1, 9 do
    set("n", "<Leader>" .. tostring(i), function()
      ui.nav_file(i)
    end, "Go to harpoon mark " .. i)
  end
end

-- Telescope
set("n", "<Leader>ff", ":Telescope find_files<Return>", "Find files")
set("n", "<Leader>fa", ":Telescope find_files hidden=true<Return>", "Find all files")
set("n", "<Leader>fs", ":Telescope live_grep<Return>", "Search in files")
set("n", "<Leader>fb", ":Telescope buffers<Return>", "Find buffers")
set("n", "<Leader>fo", ":Telescope oldfiles<Return>", "Find recent files")
set("n", "<Leader>fk", ":Telescope keymaps<Return>", "Find keymaps")
set("n", "<Leader>fh", ":Telescope highlights<Return>", "Find highlights")

-- Buffers
set("n", "H", ":BufferLineCyclePrev<Return>", "Previous buffer")
set("n", "L", ":BufferLineCycleNext<Return>", "Next buffer")
set("n", "<Leader>,", ":BufferLineMovePrev<Return>", "Move buffer left")
set("n", "<Leader>.", ":BufferLineMoveNext<Return>", "Move buffer right")
set("n", "<Leader>c", ":bdelete<Return>", "Close buffer")
set("n", "<Leader>C", ":b# <bar> bd#<Return>", "Close buffer, without closing the window")

-- Packages
set("n", "<Leader>mm", ":Mason<Return>", "Launch Mason")

-- Git
set("n", "gs", ":vertical rightbelow Git<Return>", "Open git status")
set("n", "gh", ":diffget //2<Return>", "Use left diff hunk")
set("n", "gm", ":GitMessenger<Return>", "Open git messenger")
set("n", "gl", ":diffget //3<Return>", "Use right diff hunk")
set("n", "gL", ":LazyGit<Return>", "Open lazy git")

--- Setup Git keymaps
---@param buffer number
---@param gitsigns any
function M.setup_git_keymaps(buffer, gitsigns)
  local opts = { noremap = true, silent = true, buffer = buffer }

  -- Navigation
  set("n", "<Leader>gj", function()
    if vim.wo.diff then
      return "<Leader>gj"
    end

    vim.schedule(function()
      gitsigns.next_hunk()
    end)

    return "<Ignore>"
  end, "Go to next git hunk", utils.MergeTables({ opts, { expr = true } }))

  set("n", "<Leader>gk", function()
    if vim.wo.diff then
      return "<Leader>gk"
    end

    vim.schedule(function()
      gitsigns.prev_hunk()
    end)

    return "<Ignore>"
  end, "go to previous hunk", utils.MergeTables({ opts, { expr = true } }))

  -- Stage
  set("n", "<Leader>gS", gitsigns.stage_buffer, "Stage buffer")
  set("n", "<Leader>gu", gitsigns.undo_stage_hunk, "Undo stage hunk")
  set("n", "<Leader>td", gitsigns.toggle_deleted, "Toggle deleted sections")

  -- Reset
  set({ "n", "v" }, "<Leader>gr", gitsigns.reset_hunk, "Reset hunk")

  -- Diff
  set("n", "<Leader>gd", ":Gvdiffsplit<Return>", "Diff buffer")
end

--- Setup LSP keymaps
---@param buffer number
function M.setup_lsp_keymaps(buffer)
  local opts = { noremap = true, silent = true, buffer = buffer }

  set("n", "K", ":Lspsaga hover_doc<Return>", "Show hover doc", opts)

  set("n", "gf", ":Lspsaga finder<Return>", "Find definition", opts)
  set("n", "gd", ":Lspsaga goto_definition<Return>", "Go to definition", opts)
  set("n", "gD", ":Lspsaga peek_definition<Return>", "Peek definition", opts)
  set("n", "gi", ":lua vim.lsp.buf.implementation()<Return>", "Go to implementation", opts)

  set("n", "<Leader>lf", ":Lspsaga lsp_finder<Return>", "Find references", opts)
  set("n", "<Leader>la", ":Lspsaga code_action<Return>", "Code action", opts)
  set("n", "<Leader>lr", ":Lspsaga rename<Return>", "Rename symbol", opts)
  set("n", "<Leader>ld", ":Lspsaga show_line_diagnostics<Return>", "Show line diagnostics", opts)
  set("n", "<Leader>lc", ":Lspsaga show_cursor_diagnostics<Return>", "Show cursor diagnostics", opts)
  set("n", "<Leader>lb", ":Lspsaga show_buf_diagnostics<Return>", "Show buffer diagnostics", opts)
  set("n", "<Leader>lw", ":Lspsaga show_workspace_diagnostics<Return>", "Show workspace diagnostics", opts)

  local diagnostic_status, diagnostic = pcall(require, "lspsaga.diagnostic")
  if diagnostic_status then
    set("n", "<Leader>lj", function()
      diagnostic:goto_next()
    end, "Jump to next diagnostic", opts)

    set("n", "<Leader>lk", function()
      diagnostic:goto_prev()
    end, "Jump to previous diagnostic", opts)
  end
end

--- Setup formatting keymaps
---@param conform any
function M.setup_formatting_keymaps(conform)
  set({ "n", "v" }, "<Leader>lF", function()
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
  set("n", "<Leader>lL", function()
    lint.try_lint()
  end, "Lint file")
end

return M
