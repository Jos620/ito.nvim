local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then return end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then return end

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
  set("n", "<Leader>d", ":Lspsaga show_line_diagnostics<Return>", opts)
  set("n", "<Leader>d", ":Lspsaga show_cursor_diagnostics<Return>", opts)

  set("n", "[d", ":Lspsaga diagnostic_jump_prev<Return>", opts)
  set("n", "]d", ":Lspsaga diagnostic_jump_next<Return>", opts)
  set("n", "K", ":Lspsaga hover_doc<Return>", opts)
  set("n", "<Leader>o", ":LSoutlineToggle<Return>", opts)

  if client.name == "tsserver" then
    set("n", "<Leader>lfr", ":TypescriptRenameFile<Return>", opts)
  end
end

-- Enable auto completion 
local capabilities = cmp_nvim_lsp.default_capabilities()
