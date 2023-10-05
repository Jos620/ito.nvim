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
        lua = { "stylua" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },
    })

    require("jos620.core.keymaps").setup_formatting_keymaps(conform)
  end,
}
