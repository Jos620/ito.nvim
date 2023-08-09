return {
  "windwp/nvim-autopairs",
  config = function()
    local ap_status, autopairs = pcall(require, "nvim-autopairs")
    if not ap_status then
      return
    end

    autopairs.setup({})
  end,
}
