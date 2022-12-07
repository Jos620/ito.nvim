-- Auto reloads the plugins
vim.cmd [[
  augroup reload_packer
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Auto install Packer
local ensure_packer_installed = function()
  local fn = vim.fn
  local path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  if fn.empty(fn.glob(path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", path })
    vim.cmd("packadd packer.nvim")

    return true
  end

  return false
end

local packer_bootstrap = ensure_packer_installed()

local status, packer = pcall(require, "packer")
if not status then return end

return packer.startup(function(use)
  use("wbthomason/packer.nvim")

  -- Theme
  use("bluz71/vim-nightfly-guicolors")

  -- Status Line
  use("nvim-lualine/lualine.nvim")

  -- Window management
  use("christoomey/vim-tmux-navigator")
  use("szw/vim-maximizer")

  if packer_bootstrap then
    packer.sync()
  end
end)

