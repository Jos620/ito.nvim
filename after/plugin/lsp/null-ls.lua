local setup, null_ls = pcall(require, "null-ls")
if not setup then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local cspell_config = {
  filetypes = { "markdown", "tex", "text", "typescript", "typescriptreact", "typescript.tsx", "vimwiki" },
  condition = function()
    return vim.fn.executable("cspell") == 1
  end,
}

local eslint_file_types = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx",
  "svelte",
  "vue",
}

null_ls.setup({
  sources = {
    -- Spell checking
    diagnostics.cspell.with(cspell_config),
    code_actions.cspell.with(cspell_config),

    -- Lua
    formatting.stylua,

    -- JavaScript / TypeScript
    formatting.eslint_d.with({
      filetypes = eslint_file_types,
    }),
    diagnostics.eslint_d.with({
      filetypes = eslint_file_types,
      condition = function(utils)
        local config_files = {
          ".eslintrc",
          ".eslintrc.cjs",
        }

        return utils.root_has_file(config_files)
      end,
      extra_args = { "--ignore-path", ".gitignore", "--ignore-pattern", "node_modules" },
    }),
    code_actions.eslint_d,
    formatting.prettierd.with({
      filetypes = eslint_file_types,
      condition = function(utils)
        local config_files = {
          ".prettierrc",
          ".prettierrc.js",
          ".prettierrc.cjs",
          "prettier.config.js",
          "prettier.config.cjs",
          "prettier.config.ts",
        }

        return utils.root_has_file(config_files)
      end,
    }),

    -- Rust
    formatting.rustfmt,

    -- GoLang
    formatting.gofmt,
    formatting.goimports,

    -- Dart
    formatting.dart_format,
  },
  on_attach = function(current_client, bufnr)
    if current_client.supports_method("textDocument/formatting") then
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            filter = function(client)
              if vim.bo.filetype == "prisma" then
                return client.name == "prismals"
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
