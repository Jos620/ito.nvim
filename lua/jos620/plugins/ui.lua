local colors = require("jos620.core.colors")

return {
  { -- Better UI for Neovim
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
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
    end,
  },

  { -- Notifications
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")

      notify.setup({
        background_colour = colors.black,
        timeout = 8000,
      })

      vim.notify = notify
    end,
  },
}
