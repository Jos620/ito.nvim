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
  view = {
    mappings = {
      list = {
        { key = "l", action = "edit" },
        { key = "h", action = "close_node" },
        { key = "e", action = "" },
        { key = "<Return>", action = "cd" },
      },
    },
    cursorline = not vim.g.neovide,
  },

  sync_root_with_cwd = true,
})
