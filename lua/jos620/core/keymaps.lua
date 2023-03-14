local set = vim.keymap.set

local silent = { silent = true }

-- Exit insert mode
set("i", "jk", "<Esc>")
set("i", "jj", "<Esc>:wa<Return>", silent)

-- Search and replace
set("n", "<C-S>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Highlights
set("n", "<Leader>h", function()
  vim.cmd([[nohlsearch]])
  vim.cmd([[echom '']])
end, silent)

-- Navigation
set("n", "gg", "gg0zz")
set("n", "G", "G0zz")
set("n", "gh", "^")
set("n", "gl", "$")

-- Do not yank with "X" and "P"
set({ "n", "v" }, "x", '"_x')
set({ "n", "v" }, "X", '"_X')
set("x", "p", '"_dP')
set("x", "<Leader>p", "p")

-- Move lines with visual
set("v", "J", ":m '>+1<Return>gv=gv")
set("v", "K", ":m '<-2<Return>gv=gv")

-- "ie" as all file text objects
set("n", "vie", "ggVG")
set("n", "cie", "ggcG")
set("n", "die", "ggdG")
set("n", "yie", "ggVGy")

-- Better movimentation on wrapped lines
set("n", "j", "gj")
set("n", "k", "gk")

-- Reload configuration
set("n", "<Leader>r", ":ReloadConfig<Return>", silent)

-- Line indent with visual
set("v", ">", ">gv")
set("v", "<", "<gv")

-- Split window
set("n", "<Leader>sv", "<C-w>v")
set("n", "<Leader>sh", "<C-w>s")
set("n", "<Leader>se", "<C-w>=")
set("n", "<Leader>q", ":quit<Return>", silent)
set("n", "<Leader>x", ":close<Return>", silent)

-- Split resize
set("n", "<M-up>", "<C-w>+")
set("n", "<M-down>", "<C-w>-")
set("n", "<M-right>", "<C-w>>")
set("n", "<M-left>", "<C-w><")
set("n", "+", "<C-w>+")
set("n", "_", "<C-w>-")
set("n", ">>", "<C-w>>")
set("n", "<<", "<C-w><")

set("n", "<C-m>", ":MaximizerToggle<Return>", silent)

set("n", "<Leader>Sh", "<C-w>t<C-w>H")
set("n", "<Leader>Sv", "<C-w>t<C-w>K")

-- Increase / decrease
set("n", "=", "<C-a>")
set("n", "-", "<C-x>")

-- File tree
set("n", "<Leader>e", ":NvimTreeFindFileToggle<Return>", silent)

-- Telescope
set("n", "<Leader>ff", ":Telescope find_files<Return>", silent)
set("n", "<Leader>fa", ":Telescope find_files hidden=true<Return>", silent)
set("n", "<Leader>fs", ":Telescope live_grep<Return>", silent)
set("n", "<Leader>fb", ":Telescope buffers<Return>", silent)
set("n", "<Leader>fo", ":Telescope oldfiles<Return>", silent)
set("n", "<Leader>fk", ":Telescope keymaps<Return>", silent)
set("n", "<Leader>fh", ":Telescope highlights<Return>", silent)
set("n", "<Leader>fgf", ":Telescope git_status<Return>", silent)
set("n", "<Leader>fgb", ":Telescope git_branches<Return>", silent)
set("n", "<Leader>fgc", ":Telescope git_commits<Return>", silent)

-- Buffers
set("n", "H", ":BufferLineCyclePrev<Return>", silent)
set("n", "L", ":BufferLineCycleNext<Return>", silent)
set("n", "<Leader>,", ":BufferLineMovePrev<Return>", silent)
set("n", "<Leader>.", ":BufferLineMoveNext<Return>", silent)
set("n", "<Leader>c", ":bdelete<Return>", silent)

-- Packages
set("n", "<Leader>pi", ":PackerInstall<Return>", silent)
set("n", "<Leader>pc", ":PackerCompile<Return>", silent)
set("n", "<Leader>ps", ":PackerSync<Return>", silent)
set("n", "<Leader>mm", ":Mason<Return>", silent)

-- LSP
local function setup_lsp_keymaps(buffer)
  local opts = { noremap = true, silent = true, buffer = buffer }

  set("n", "gf", ":Lspsaga lsp_finder<Return>", opts)
  set("n", "gd", ":Lspsaga peek_definition<Return>", opts)
  set("n", "gD", ":lua vim.lsp.buf.declaration()<Return>", opts)
  set("n", "gi", ":lua vim.lsp.buf.implementation()<Return>", opts)

  set("n", "<Leader>la", ":Lspsaga code_action<Return>", opts)
  set("n", "<Leader>lr", ":Lspsaga rename<Return>", opts)
  set("n", "<Leader>ld", ":Lspsaga show_line_diagnostics<Return>", opts)
  set("n", "<Leader>lc", ":Lspsaga show_cursor_diagnostics<Return>", opts)
  set("n", "<Leader>lb", ":Lspsaga show_buf_diagnostics<Return>", opts)
  set("n", "<Leader>li", ":Lspsaga lsp_finder<Return>", opts)

  set("n", "<Leader>lj", ":Lspsaga diagnostic_jump_next<Return>", opts)
  set("n", "<Leader>lk", ":Lspsaga diagnostic_jump_prev<Return>", opts)
  set("n", "K", ":Lspsaga hover_doc<Return>", opts)
end

return {
  setup_lsp_keymaps = setup_lsp_keymaps,
}
