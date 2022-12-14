local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
  return
end

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
})
