return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local status, lint = pcall(require, "lint")
    if not status then
      return
    end

    lint.linters_by_ft = {
      typescript = { "eslint_d" },
      javascript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      vue = { "eslint_d" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({
      "BufWritePost",
      "BufEnter",
      "InsertLeave",
    }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    require("jos620.core.keymaps").setup_linting_keymaps(lint)
  end,
}
