return {
  "jayp0521/mason-null-ls.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "jose-elias-alvarez/null-ls.nvim",
  },
  config = function()
    local status, mason_null_ls = pcall(require, "mason-null-ls")
    if not status then
      return
    end

    mason_null_ls.setup({
      ensure_installed = {
        "eslint_d",
        "prettierd",
        "stylua",
      },
    })
  end,
}
