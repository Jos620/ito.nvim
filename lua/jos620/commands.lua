vim.cmd("command! ReloadConfig lua ReloadConfig()")

vim.cmd("command! Harpoon lua require('harpoon.ui').toggle_quick_menu()")
vim.cmd("command! HarpoonAdd lua require('harpoon.mark').add_file()")
