local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
  return
end

local setup_nvim_tree_keymaps = require("jos620.core.keymaps").setup_nvim_tree_keymaps

vim.g.loaded = true
vim.g.loaded_netrwPlugin = true

nvim_tree.setup({
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
  view = {
    cursorline = not vim.g.neovide,
  },

  sync_root_with_cwd = true,
  on_attach = setup_nvim_tree_keymaps,
})
