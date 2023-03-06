local setup, null_ls = pcall(require, "null-ls")
if not setup then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local cspell_config = {
  filetypes = { "markdown", "tex", "text", "typescript", "typescriptreact", "typescript.tsx", "vimwiki" },
  condition = function(utils)
    local have_cspell = utils.root_has_file("cspell.json") and utils.executable("cspell")

    return have_cspell
  end,
}

null_ls.setup({
  sources = {
    -- Spell checking
    diagnostics.cspell.with(cspell_config),
    code_actions.cspell.with(cspell_config),

    -- Lua
    formatting.stylua,

    -- JavaScript / TypeScript
    formatting.eslint_d,
    diagnostics.eslint_d.with({
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      condition = function(utils)
        return utils.root_has_file(".eslintrc")
      end,
      extra_args = { "--ignore-path", ".gitignore", "--ignore-pattern", "node_modules" },
    }),
    code_actions.eslint_d,
    formatting.prettierd.with({
      filetypes = { "svelte" },
    }),

    -- Rust
    formatting.rustfmt,
  },
  on_attach = function(current_client, bufnr)
    if current_client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            filter = function(client)
              if vim.bo.filetype == "svelte" then
                return client.name == "svelte"
              end

              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
  end,
})
