local status, flutter_tools = pcall(require, "flutter-tools")
if not status then
  return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

flutter_tools.setup({
  ui = {
    border = "rounded",
  },
  lsp = {
    on_attach = function(_, buffer)
      require("jos620.core.keymaps").setup_lsp_keymaps(buffer)
    end,
    capabilities = cmp_nvim_lsp.default_capabilities(),
  },
  widget_guides = {
    enabled = true,
  },
})
