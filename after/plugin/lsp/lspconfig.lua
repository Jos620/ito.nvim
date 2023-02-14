local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local typescript_status, typescript = pcall(require, "typescript")
if not typescript_status then
  return
end

local fn = vim.fn

local on_attach = function(client, buffer)
  local set = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = buffer }

  set("n", "gf", ":Lspsaga lsp_finder<Return>", opts)
  set("n", "gd", ":Lspsaga peek_definition<Return>", opts)
  set("n", "gD", ":lua vim.lsp.buf.declaration()<Return>", opts)
  set("n", "gi", ":lua vim.lsp.buf.implementation()<Return>", opts)

  set("n", "<Leader>la", ":Lspsaga code_action<Return>", opts)
  set("n", "<Leader>lr", ":Lspsaga rename<Return>", opts)
  set("n", "<Leader>ld", ":Lspsaga show_line_diagnostics<Return>", opts)
  set("n", "<Leader>lc", ":Lspsaga show_cursor_diagnostics<Return>", opts)
  set("n", "<Leader>lb", ":Lspsaga show_buf_diagnostics<Return>", opts)

  set("n", "<Leader>lj", ":Lspsaga diagnostic_jump_next<Return>", opts)
  set("n", "<Leader>lk", ":Lspsaga diagnostic_jump_prev<Return>", opts)
  set("n", "K", ":Lspsaga hover_doc<Return>", opts)
  set("n", "<Leader>o", ":LSoutlineToggle<Return>", opts)

  if client.name == "tsserver" then
    set("n", "<Leader>lfr", ":TypescriptRenameFile<Return>", opts)
  end
end

-- Enable auto completion
local capabilities = cmp_nvim_lsp.default_capabilities()

local servers = {
  "html",
  "cssls",
  "tailwindcss",
  "rust_analyzer",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

-- TypeScript
typescript.setup({
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
  },
})

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
