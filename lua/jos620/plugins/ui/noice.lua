return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    local status, noice = pcall(require, "noice")
    if not status then
      return
    end

    noice.setup()
  end,
}
