local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazy_path,
  })
end
vim.opt.rtp:prepend(lazy_path)

local status, lazy = pcall(require, "lazy")
if not status then
  return
end

lazy.setup({
  { import = "jos620.plugins" },
  { import = "jos620.plugins.theme" },
  { import = "jos620.plugins.theme.colorscheme" },
  { import = "jos620.plugins.ui" },
  { import = "jos620.plugins.telescope" },
  { import = "jos620.plugins.navigation" },
  { import = "jos620.plugins.lsp" },
  { import = "jos620.plugins.lsp.mason" },
  { import = "jos620.plugins.lsp.cmp" },
  { import = "jos620.plugins.lsp.snippets" },
  { import = "jos620.plugins.lsp.languages" },
  { import = "jos620.plugins.lsp.formatting" },
  { import = "jos620.plugins.git" },
  { import = "jos620.plugins.ai" },
}, {
  colorscheme = "vitesse",
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
  },
})
