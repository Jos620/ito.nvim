local status, flutter_tools = pcall(require, "flutter-tools")
if not status then
  return
end

flutter_tools.setup({
  dev_log = {
    enabled = false,
  },
  lsp = {
    on_attach = function(_, buffer)
      require("jos620.core.keymaps").setup_lsp_keymaps(buffer)
    end,
  },
})
