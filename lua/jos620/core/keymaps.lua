local set = vim.keymap.set

local silent = { silent = true }

-- Exit insert mode
set("i", "jk", "<Esc>")
set("i", "jj", "<Esc>:wa<Return>", silent)

-- Save
set("n", "<C-s>", ":write<Return>")

-- Highlights
set("n", "<Leader>h", ":set hlsearch!<Return>", silent)

-- Do not yank with "X" and "C"
set({ "n", "v" }, "x", '"_x')
set({ "n", "v" }, "X", '"_X')
set({ "n", "v" }, "c", '"_c')
set({ "n", "v" }, "C", '"_C')

-- Move lines with visual
set("v", "J", ":m '>+1<Return>gv=gv")
set("v", "K", ":m '<-2<Return>gv=gv")

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
set("n", "<C-up>", "<C-w>+")
set("n", "<C-down>", "<C-w>-")
set("n", "<C-right>", "<C-w>>")
set("n", "<C-left>", "<C-w><")

set("n", "<C-m>", ":MaximizerToggle<Return>", silent)

-- Increase / decrease
set("n", "=", "<C-a>")
set("n", "-", "<C-x>")

-- File tree
set("n", "<Leader>e", ":NvimTreeFindFileToggle<Return>", silent)

-- Telescope
set("n", "<Leader>ff", ":Telescope find_files<Return>", silent)
set("n", "<Leader>fa", ":Telescope find_files hidden=true<Return>", silent)
set("n", "<Leader>fs", ":Telescope live_grep<Return>", silent)
set("n", "<Leader>fg", ":Telescope git_status<Return>", silent)
set("n", "<Leader>fb", ":Telescope buffers<Return>", silent)
set("n", "<Leader>fo", ":Telescope oldfiles<Return>", silent)
set("n", "<Leader>fk", ":Telescope keymaps<Return>", silent)
set("n", "<Leader>fh", ":Telescope highlights<Return>", silent)

-- Buffers
set("n", "H", ":BufferLineCyclePrev<Return>", silent)
set("n", "L", ":BufferLineCycleNext<Return>", silent)
set("n", "<Leader>c", ":bdelete<Return>", silent)

-- Packages
set("n", "<Leader>pi", ":PackerInstall<Return>", silent)
set("n", "<Leader>pc", ":PackerCompile<Return>", silent)
set("n", "<Leader>ps", ":PackerSync<Return>", silent)
set("n", "<Leader>mm", ":Mason<Return>", silent)
