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

