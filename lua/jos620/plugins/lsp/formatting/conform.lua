return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local status, conform = pcall(require, "conform")
    if not status then
      return
    end

    local javascript_formatters = { "eslint_d" }
    local prettier_configs = {
      ".prettierrc",
      ".prettierrc.yaml",
    }

    if RootHasFile(prettier_configs) then
      table.insert(javascript_formatters, "prettierd")
    end

    conform.setup({
      formatters_by_ft = {
        typescript = javascript_formatters,
        javascript = javascript_formatters,
        typescriptreact = javascript_formatters,
        javascriptreact = javascript_formatters,
        vue = javascript_formatters,
        lua = { "stylua" },
        css = { "stylelint" },
        scss = { "stylelint" },
        html = { "prettierd" },
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
