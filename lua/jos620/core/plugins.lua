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

require("lazy").setup({
  spec = {
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
  },
  defaults = {
    version = false,
  },
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
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  debug = false,
})
