return {
  { -- Better UI for Neovim
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      local status, noice = pcall(require, "noice")
      if not status then
        return
      end

      noice.setup({
        routes = {
          {
            filter = {
              event = "notify",
              find = "No information available",
            },
            opts = {
              skip = true,
            },
          },
        },
      })

      local colors = require("jos620.core.colors")

      local notify_status, notify = pcall(require, "notify")
      if not notify_status then
        return
      end

      vim.notify = require("notify")

      notify.setup({
        background_colour = colors.black,
      })
    end,
  },
}
