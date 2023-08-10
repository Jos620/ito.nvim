return {
  "karb94/neoscroll.nvim",
  event = "BufReadPre",
  config = function()
    local status, neoscroll = pcall(require, "neoscroll")

    if not status then
      return
    end

    neoscroll.setup({
      mappings = { "<C-u>", "<C-d>", "zt", "zz", "zb" },
      hide_cursor = false,
    })
  end,
}
