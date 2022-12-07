local set = vim.keymap.set

-- Exit insert mode
set("i", "jk", "<C-[>")

-- Save
set("n", "<C-s>", ":write<Return>")

-- Do not yank with "x"
set("n", "x", '"_x')

-- Navigate to start / end of the file
set("n", "<Leader>h", "^")
set("n", "<Leader>l", "$")

-- Line indent with visual
set("v", ">", ">V")
set("v", "<", "<V")

-- Split window
set("n", "<Leader>sv", "<C-w>v")
set("n", "<Leader>sh", "<C-w>s")
set("n", "<Leader>se", "<C-w>=")
set("n", "<Leader>q", ":quit<Return>", { silent = true })
set("n", "<Leader>c", ":close<Return>", { silent = true })

-- Split resize
set("n", "<C-up>", "<C-w>+")
set("n", "<C-down>", "<C-w>-")
set("n", "<C-right>", "<C-w>>")
set("n", "<C-left>", "<C-w><")

set("n", "<C-\\>", ":MaximizerToggle<Return>", { silent = true })

-- Tabs
set("n", "<Leader>t", ":tabnew<Return>", { silent = true })
set("n", "<Leader>x", ":tabclose<Return>", { silent = true })
set("n", "L", ":tabn<Return>", { silent = true })
set("n", "H", ":tabp<Return>", { silent = true })

-- Increase / decrease
set("n", "=", "<C-a>")
set("n", "-", "<C-x>")

-- File tree
set("n", "<Leader>e", ":NvimTreeToggle<Return>", { silent = true })
