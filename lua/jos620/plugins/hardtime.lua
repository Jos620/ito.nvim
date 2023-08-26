return {
  "m4xshen/hardtime.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
  },
  event = "User FileOpened",
  config = function()
    local status, hardtime = pcall(require, "hardtime")
    if not status then
      return
    end

    hardtime.setup({
      max_time = 2000,
      max_count = 5,
      disable_mouse = false,
      restricted_keys = {
        ["j"] = {},
        ["k"] = {},
      },
    })
  end,
}
