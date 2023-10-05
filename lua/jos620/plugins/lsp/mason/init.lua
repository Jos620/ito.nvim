return {
  "williamboman/mason.nvim",
  lazy = false,
  config = function()
    local mason_status, mason = pcall(require, "mason")
    if not mason_status then
      return
    end

    mason.setup({
      PATH = "prepend",
    })
  end,
}
