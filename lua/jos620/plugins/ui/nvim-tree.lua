return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    local status, nvim_tree = pcall(require, "nvim-tree")
    if not status then
      return
    end

    local setup_nvim_tree_keymaps = require("jos620.core.keymaps").setup_nvim_tree_keymaps

    vim.g.loaded = true
    vim.g.loaded_netrwPlugin = true

    nvim_tree.setup({
      on_attach = setup_nvim_tree_keymaps,
      sync_root_with_cwd = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = true,

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

      renderer = {
        icons = {
          show = {
            folder_arrow = false,
          },
        },
      },
    })
  end,
}
