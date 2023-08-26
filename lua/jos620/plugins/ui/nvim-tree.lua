return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
  event = "User DirOpened",
  config = function()
    local status, nvim_tree = pcall(require, "nvim-tree")
    if not status then
      return
    end

    vim.g.loaded = true
    vim.g.loaded_netrwPlugin = true

    nvim_tree.setup({
      on_attach = function(bufnr)
        local api_status, api = pcall(require, "nvim-tree.api")
        local keymaps_status, keymaps = pcall(require, "jos620.core.keymaps")

        if api_status and keymaps_status then
          keymaps.setup_nvim_tree_keymaps(api, bufnr)
        end
      end,
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
