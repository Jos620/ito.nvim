local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

treesitter.setup({
  highlight = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },

  ensure_installed = {
    "typescript",
    "javascript",
    "tsx",
    "html",
    "css",
    "json",
    "markdown",
    "markdown_inline",
    "lua",
    "vim",
    "yaml",
    "toml",
    "bash",
  },

  auto_install = true,
})
