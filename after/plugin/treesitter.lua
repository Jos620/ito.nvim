local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

treesitter.setup({
  highlight = { enable = true },
  indent = { enable = true },

  ensure_installed = {
    "json",
    "javascript",
    "typescript",
    "tsx",
    "html",
    "css",
    "lua",
  },

  auto_install = true,
})
