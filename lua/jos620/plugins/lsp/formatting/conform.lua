return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local status, conform = pcall(require, "conform")
    if not status then
      return
    end

    conform.setup({
      formatters_by_ft = {
        typescript = { "eslint_d", "prettierd" },
        javascript = { "eslint_d", "prettierd" },
        typescriptreact = { "eslint_d", "prettierd" },
        javascriptreact = { "eslint_d", "prettierd" },
        lua = { "stylua" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 750,
      },
    })

    require("jos620.core.keymaps").setup_formatting_keymaps(conform)
  end,
}
