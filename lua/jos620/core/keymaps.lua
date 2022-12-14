local set = vim.keymap.set

local opts = { silent = true }

-- Exit insert mode
set("i", "jk", "<Esc>")
set("i", "jj", "<Esc>:wa<Return>", opts)

-- Save
set("n", "<C-s>", ":write<Return>")

-- Do not yank with "x"
set("n", "x", '"_x')

-- Reload configuration
set("n", "<Leader>r", ":ReloadConfig<Return>", opts)

-- Toggle transparent
set("n", "<Leader>t", function()
  local next_state = IsTransparent and "false" or "true"
  vim.cmd("Transparent " .. next_state)
end, opts)

-- Line indent with visual
set("v", ">", ">gv")
set("v", "<", "<gv")

-- Split window
set("n", "<Leader>sv", "<C-w>v")
set("n", "<Leader>sh", "<C-w>s")
set("n", "<Leader>se", "<C-w>=")
set("n", "<Leader>q", ":quit<Return>", opts)
set("n", "<Leader>c", ":close<Return>", opts)

-- Split resize
set("n", "<C-up>", "<C-w>+")
set("n", "<C-down>", "<C-w>-")
set("n", "<C-right>", "<C-w>>")
set("n", "<C-left>", "<C-w><")

set("n", "<C-\\>", ":MaximizerToggle<Return>", opts)

-- Increase / decrease
set("n", "=", "<C-a>")
set("n", "-", "<C-x>")

-- File tree
set("n", "<Leader>e", ":NvimTreeToggle<Return>", opts)

-- Telescope
set("n", "<Leader>ff", ":Telescope find_files<Return>", opts)
set("n", "<Leader>fg", ":Telescope live_grep<Return>", opts)
set("n", "<Leader>fs", ":Telescope grep_string<Return>", opts)
set("n", "<Leader>fb", ":Telescope buffers<Return>", opts)
set("n", "<Leader>fo", ":Telescope oldfiles<Return>", opts)
set("n", "<Leader>fk", ":Telescope keymaps<Return>", opts)

-- Buffers
set("n", "H", ":BufferLineCyclePrev<Return>", opts)
set("n", "L", ":BufferLineCycleNext<Return>", opts)
set("n", "<Leader>x", ":bdelete<Return>", opts)
