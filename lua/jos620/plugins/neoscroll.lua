local neoscroll_keys = { "<C-u>", "<C-d>", "zt", "zz", "zb" }

return {
  "karb94/neoscroll.nvim",
  keys = neoscroll_keys,
  config = function()
    local status, neoscroll = pcall(require, "neoscroll")

    if not status then
      return
    end

    neoscroll.setup({
      mappings = neoscroll_keys,
      hide_cursor = false,
    })
  end,
}
