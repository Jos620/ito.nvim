local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local fn = vim.fn

local on_attach = function(_, buffer)
  require("jos620.core.keymaps").setup_lsp_keymaps(buffer)
end

-- Enable auto completion
local capabilities = cmp_nvim_lsp.default_capabilities()

local servers = {
  "html",
  "cssls",
  "tailwindcss",
  "rust_analyzer",
  "jsonls",
  "svelte",
  "prismals",
  "unocss",
  "marksman",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

-- Lua
lspconfig["lua_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      -- Add global "vim"
      diagnostics = {
        globals = { "vim" },
      },
      -- Add runtime files
      workspace = {
        library = {
          [fn.expand("$VIMRUNTIME/lua")] = true,
          [fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})

-- Vue
lspconfig.volar.setup({
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue", "json" },
  settings = {
    css = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
    scss = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
})

-- Golang
lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
  setting = {
    gopls = {
      completeUnimported = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})

return {
  servers = servers,
  on_attach = on_attach,
  capabilities = capabilities,
}
