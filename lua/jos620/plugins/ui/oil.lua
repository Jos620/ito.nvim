return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local status, oil = pcall(require, "oil")
    if not status then
      return
    end

    oil.setup()
  end,
}