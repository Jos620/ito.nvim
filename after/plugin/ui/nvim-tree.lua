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
    float = {
      enable = true,
      quit_on_focus_loss = false,
      open_win_config = function()
        local HEIGHT_RATIO = 0.8
        local WIDTH_RATIO = 0.75

        local screen_width = vim.opt.columns:get()
        local window_width = math.ceil(screen_width * WIDTH_RATIO)
        local screen_height = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_height = math.ceil(screen_height * HEIGHT_RATIO)

        local position = {
          row = ((vim.opt.lines:get() - window_height) / 2) - vim.opt.cmdheight:get(),
          col = (screen_width - window_width) / 2,
        }

        if window_width < 80 and window_width < screen_width / 2 then
          window_width = 80
        end

        if window_height < 20 and window_height < screen_height / 2 then
          window_height = 20
        end

        return {
          border = "rounded",
          relative = "editor",
          row = position.row,
          col = position.col,
          width = window_width,
          height = window_height,
        }
      end,
    },
  },

  renderer = {
    icons = {
      show = {
        folder_arrow = false,
      },
    },
  },
})
