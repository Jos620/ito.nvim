local set = vim.keymap.set

local opts = { silent = true }

-- Exit insert mode
set("i", "jk", "<Esc>")
set("i", "jj", "<Esc>:wa<Return>", opts)

-- Save
set("n", "<C-s>", ":write<Return>")

-- Do not yank with "x"
set("n", "x", '"_x')

-- Move lines with visual
set("v", "J", ":m '>+1<Return>gv=gv")
set("v", "K", ":m '<-2<Return>gv=gv")

-- Reload configuration
set("n", "<Leader>r", ":ReloadConfig<Return>", opts)

-- Line indent with visual
set("v", ">", ">gv")
set("v", "<", "<gv")

-- Split window
set("n", "<Leader>sv", "<C-w>v")
set("n", "<Leader>sh", "<C-w>s")
set("n", "<Leader>se", "<C-w>=")
set("n", "<Leader>q", ":quit<Return>", opts)
set("n", "<Leader>x", ":close<Return>", opts)

-- Split resize
set("n", "<C-up>", "<C-w>+")
set("n", "<C-down>", "<C-w>-")
set("n", "<C-right>", "<C-w>>")
set("n", "<C-left>", "<C-w><")

set("n", "<C-m>", ":MaximizerToggle<Return>", opts)

-- Increase / decrease
set("n", "=", "<C-a>")
set("n", "-", "<C-x>")

-- File tree
set("n", "<Leader>e", ":NvimTreeFindFileToggle<Return>", opts)

-- Telescope
set("n", "<Leader>ff", ":Telescope find_files<Return>", opts)
set("n", "<Leader>fs", ":Telescope live_grep<Return>", opts)
set("n", "<Leader>fg", ":Telescope git_status<Return>", opts)
set("n", "<Leader>fb", ":Telescope buffers<Return>", opts)
set("n", "<Leader>fo", ":Telescope oldfiles<Return>", opts)
set("n", "<Leader>fk", ":Telescope keymaps<Return>", opts)
set("n", "<Leader>fh", ":Telescope highlights<Return>", opts)

-- Buffers
set("n", "H", ":BufferLineCyclePrev<Return>", opts)
set("n", "L", ":BufferLineCycleNext<Return>", opts)
set("n", "<Leader>c", ":bdelete<Return>", opts)
