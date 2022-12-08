-- Auto reloads the plugins
vim.cmd([[
  augroup reload_packer
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

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
if not status then
  return
end

return packer.startup(function(use)
  use("wbthomason/packer.nvim")

  -- Theme
  use("bluz71/vim-nightfly-guicolors")
  use("nvim-tree/nvim-web-devicons")

  -- Status Line
  use("nvim-lualine/lualine.nvim")

  -- File tree
  use("nvim-tree/nvim-tree.lua")

  -- Window management
  use("christoomey/vim-tmux-navigator")
  use("szw/vim-maximizer")

  -- Surrounds / Pairs
  use("windwp/nvim-autopairs")
  use("tpope/vim-surround")

  -- Navigation
  use("justinmk/vim-sneak")

  -- Comments
  use("numToStr/Comment.nvim")

  -- Fuzzy finder
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- Auto completion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-nvim-lsp")

  -- Snippets
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  -- LSP
  use("neovim/nvim-lspconfig")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("jose-elias-alvarez/typescript.nvim")
  use("onsails/lspkind.nvim")
  use({ "glepnir/lspsaga.nvim", branch = "main" })

  -- Formatting & linting
  use("jose-elias-alvarez/null-ls.nvim")
  use("jayp0521/mason-null-ls.nvim")

  -- Dependencies
  use("nvim-lua/plenary.nvim")

  if packer_bootstrap then
    packer.sync()
  end
end)
