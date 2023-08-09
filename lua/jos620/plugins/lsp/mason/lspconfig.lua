return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    local status, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not status then
      return
    end

    mason_lspconfig.setup({
      ensure_installed = {
        -- FrontEnd
        "html",
        "cssls",
        "tailwindcss",
        "unocss",
        "volar",
        "svelte",

        -- BackEnd
        "tsserver",
        "rust_analyzer",

        -- Utils
        "lua_ls",
        "jsonls",
        "prismals",
      },
    })
  end,
}
