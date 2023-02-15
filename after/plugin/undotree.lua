local set = vim.keymap.set

vim.g.undotree_WindowLayout = 3

set("n", "<Leader>u", ":UndotreeToggle<Return>", { silent = true })
