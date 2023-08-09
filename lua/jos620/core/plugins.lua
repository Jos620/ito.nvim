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
})
