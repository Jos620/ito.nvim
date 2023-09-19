local function set(mode, key, command, desc, options)
  local opts = options or { silent = true }
  vim.keymap.set(mode, key, command, MergeTable(opts, { desc = desc }))
end

-- Exit insert mode
set("i", "jk", "<Esc>", "Exit insert mode")
set("i", "jj", "<Esc>:wa<Return>", "Exit insert mode and save")

-- Search and replace
set("n", "<C-S>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Search and replace")

-- Highlights
set("n", "<Leader>h", function()
  vim.cmd([[nohlsearch]])
  vim.cmd([[echom '']])
end, "Clear highlights")

-- Navigation
set("n", "f", "<Plug>Sneak_f")
set("n", "F", "<Plug>Sneak_F")

-- Scroll
set("n", "zl", "30zl", "Scroll right")
set("n", "zh", "30zh", "Scroll left")

-- Do not yank with "X" and "P"
set({ "n", "v" }, "x", '"_x', "Do not yank with 'x'")
set({ "n", "v" }, "X", '"_X', "Do not yank with 'X'")
set("x", "p", '"_dP', "Do not yank with 'p'")
set("x", "<Leader>p", "p", "Yank with 'p'")

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

-- Reload configuration
set("n", "<Leader>r", ":ReloadConfig<Return>", "Reload configuration")

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

-- Split resize
set("n", "<M-up>", "<C-w>+", "Increase window height")
set("n", "<M-down>", "<C-w>-", "Decrease window height")
set("n", "<M-right>", "<C-w>>", "Increase window width")
set("n", "<M-left>", "<C-w><", "Decrease window width")
set("n", "+", "<C-w>+", "Increase window height")
set("n", "_", "<C-w>-", "Decrease window height")
set("n", ">>", "<C-w>>", "Increase window width")
set("n", "<<", "<C-w><", "Decrease window width")

set("n", "<Leader>Sv", "<C-w>t<C-w>H", "Change split orientation to horizontal")
set("n", "<Leader>Sb", "<C-w>t<C-w>K", "Change split orientation to vertical")

-- Folds
local function setup_fold_keymaps()
  set("n", "<Leader>z", "$V%zf", "Create fold")

  local status, ufo = pcall(require, "ufo")
  if status then
    set("n", "zR", ufo.openAllFolds, "Open all folds")
    set("n", "zM", ufo.closeAllFolds, "Close all folds")
  end
end

-- Increase / decrease
set("n", "=", "<C-a>", "Increase")
set("n", "-", "<C-x>", "Decrease")

-- File tree
set("n", "<Leader>e", ":NvimTreeFindFileToggle<Return>", "Toggle file tree")
local function setup_nvim_tree_keymaps(tree_api, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }

  -- Help / Info
  set("n", "g?", tree_api.tree.toggle_help, "Help", opts)
  set("n", "K", tree_api.node.show_info_popup, "Info", opts)
  set("n", "gy", tree_api.fs.copy.absolute_path, "Copy Absolute Path", opts)
  set("n", "s", tree_api.node.run.system, "Run System", opts)
  set("n", ".", tree_api.node.run.cmd, "Run Command", opts)

  -- Open
  set("n", "l", tree_api.node.open.edit, "Open", opts)
  set("n", "v", tree_api.node.open.vertical, "Open: Vertical Split", opts)
  set("n", "b", tree_api.node.open.horizontal, "Open: Horizontal Split", opts)

  -- Basic operations
  set("n", "a", tree_api.fs.create, "Create", opts)
  set("n", "p", tree_api.fs.paste, "Paste", opts)
  set("n", "d", tree_api.fs.remove, "Delete", opts)
  set("n", "D", tree_api.fs.trash, "Trash", opts)
  set("n", "x", tree_api.fs.cut, "Cut", opts)
  set("n", "c", tree_api.fs.copy.node, "Copy", opts)
  set("n", "r", tree_api.fs.rename, "Rename", opts)
  set("n", "R", tree_api.tree.reload, "Refresh", opts)

  -- Navigation
  set("n", "h", tree_api.node.navigate.parent_close, "Close Directory", opts)
  set("n", "q", tree_api.tree.close, "Close", opts)
  set("n", "-", tree_api.tree.change_root_to_parent, "Up", opts)
  set("n", "<Return>", tree_api.tree.change_root_to_node, "CD", opts)

  -- Git / Diagnostics
  set("n", "<Leader>gj", tree_api.node.navigate.git.next, "Next Git", opts)
  set("n", "<Leader>gk", tree_api.node.navigate.git.prev, "Prev Git", opts)
  set("n", "<Leader>lj", tree_api.node.navigate.diagnostics.next, "Next Diagnostic", opts)
  set("n", "<Leader>lk", tree_api.node.navigate.diagnostics.prev, "Prev Diagnostic", opts)

  -- Filters
  set("n", "f", tree_api.live_filter.start, "Filter", opts)
  set("n", "F", tree_api.live_filter.clear, "Clean Filter", opts)
  set("n", "B", tree_api.tree.toggle_no_buffer_filter, "Toggle No Buffer", opts)
  set("n", "C", tree_api.tree.toggle_git_clean_filter, "Toggle Git Clean", opts)
  set("n", "H", tree_api.tree.toggle_hidden_filter, "Toggle Dotfiles", opts)
  set("n", "I", tree_api.tree.toggle_gitignore_filter, "Toggle Git Ignore", opts)

  -- Mouse support
  set("n", "<2-LeftMouse>", tree_api.node.open.edit, "Open", opts)
  set("n", "<2-RightMouse>", tree_api.tree.change_root_to_node, "CD", opts)
end
set("n", "<Leader>o", ":Oil<Return>", "Toggle Oil")

set("n", "<Leader>u", ":UndotreeToggle<Return>", "Toggle Undo Tree")

-- Harpoon
local function setup_harpoon_keymaps()
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

-- Terminal
set("n", "<Leader>st", ":vsplit term://zsh<Return>i", "Open terminal")

-- Telescope
set("n", "<Leader>ff", ":Telescope find_files<Return>", "Find files")
set("n", "<Leader>fa", ":Telescope find_files hidden=true<Return>", "Find all files")
set("n", "<Leader>fs", ":Telescope live_grep<Return>", "Search in files")
set("n", "<Leader>fb", ":Telescope buffers<Return>", "Find buffers")
set("n", "<Leader>fo", ":Telescope oldfiles<Return>", "Find recent files")
set("n", "<Leader>fk", ":Telescope keymaps<Return>", "Find keymaps")
set("n", "<Leader>fh", ":Telescope highlights<Return>", "Find highlights")
set("n", "<Leader>fgf", ":Telescope git_status<Return>", "Find changed files")
set("n", "<Leader>fgb", ":Telescope git_branches<Return>", "Find git branches")
set("n", "<Leader>fgc", ":Telescope git_commits<Return>", "Find git commits")
set("n", "<Leader>fm", ":Telescope harpoon marks<Return>", "Find git commits")

-- Buffers
set("n", "H", ":BufferLineCyclePrev<Return>", "Previous buffer")
set("n", "L", ":BufferLineCycleNext<Return>", "Next buffer")
set("n", "<Tab>", ":BufferLineCycleNext<Return>", "Next buffer")
set("n", "<S-Tab>", ":BufferLineCyclePrev<Return>", "Next buffer")
set("n", "<Leader>,", ":BufferLineMovePrev<Return>", "Move buffer left")
set("n", "<Leader>.", ":BufferLineMoveNext<Return>", "Move buffer right")
set("n", "<Leader>c", ":bdelete<Return>", "Close buffer")
set("n", "<Leader>C", ":b# <bar> bd#<Return>", "Close buffer, without closing the window")

-- Packages
set("n", "<Leader>pi", ":PackerInstall<Return>", "Install packages")
set("n", "<Leader>pc", ":PackerCompile<Return>", "Compile packages")
set("n", "<Leader>ps", ":PackerSync<Return>", "Sync packages")
set("n", "<Leader>mm", ":Mason<Return>", "Launch Mason")

-- Git
set("n", "gs", ":vertical rightbelow Git<Return>", "Open git status")
set("n", "gh", ":diffget //2<Return>", "Use left diff hunk")
set("n", "gm", ":GitMessenger<Return>", "Open git messenger")
set("n", "gl", ":diffget //3<Return>", "Use right diff hunk")
set("n", "gL", ":LazyGit<Return>", "Open lazy git")

local function setup_git_keymaps(buffer, gitsigns)
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
  end, "Go to next git hunk", MergeTable(opts, { expr = true }))

  set("n", "<Leader>gk", function()
    if vim.wo.diff then
      return "<Leader>gk"
    end

    vim.schedule(function()
      gitsigns.prev_hunk()
    end)

    return "<Ignore>"
  end, "go to previous hunk", MergeTable(opts, { expr = true }))

  -- Stage
  set("n", "<Leader>gS", gitsigns.stage_buffer, "Stage buffer")
  set("n", "<Leader>gu", gitsigns.undo_stage_hunk, "Undo stage hunk")
  set("n", "<Leader>gp", gitsigns.preview_hunk, "Preview hunk")
  set("n", "<Leader>td", gitsigns.toggle_deleted, "Toggle deleted sections")

  -- Reset
  set("n", "<Leader>gR", gitsigns.reset_buffer, "Reset buffer")
  set({ "n", "v" }, "<Leader>gr", gitsigns.reset_hunk, "Reset hunk")
  set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<Return>", "Select hunk")

  -- Blame
  set("n", "<Leader>gl", function()
    gitsigns.blame_line({ full = true })
  end)
  set("n", "<Leader>gb", gitsigns.toggle_current_line_blame, "Toggle blame line")

  -- Diff
  set("n", "<Leader>gd", ":Gvdiffsplit<Return>", "Diff buffer")
  set("n", "<Leader>gD", function()
    gitsigns.diffthis("~")
  end, "Diff buffer against HEAD")
end

-- LSP
local function setup_lsp_keymaps(buffer)
  local opts = { noremap = true, silent = true, buffer = buffer }

  set("n", "K", ":Lspsaga hover_doc<Return>", "Show hover doc", opts)

  set("n", "gf", ":Lspsaga lsp_finder<Return>", "Find definition", opts)
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

return {
  setup_nvim_tree_keymaps = setup_nvim_tree_keymaps,
  setup_git_keymaps = setup_git_keymaps,
  setup_lsp_keymaps = setup_lsp_keymaps,
  setup_harpoon_keymaps = setup_harpoon_keymaps,
  setup_fold_keymaps = setup_fold_keymaps,
}
