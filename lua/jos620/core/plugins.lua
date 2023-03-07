-- Auto reloads the plugins
vim.cmd([[
  augroup reload_packer
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Auto install Packer
local fn = vim.fn

local ensure_packer_installed = function()
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
  use({
    "2nthony/vitesse.nvim",
    requires = {
      "tjdevries/colorbuddy.nvim",
    },
  })
  use("nvim-tree/nvim-web-devicons")
  use("brenoprata10/nvim-highlight-colors")

  -- Status / buffer line
  use("nvim-lualine/lualine.nvim")
  use("akinsho/bufferline.nvim")

  -- File tree
  use("nvim-tree/nvim-tree.lua")

  -- Window management
  use("szw/vim-maximizer")

  -- Surrounds / Pairs / Folds
  use("windwp/nvim-autopairs")
  use("tpope/vim-surround")
  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })
  use("anuvyklack/pretty-fold.nvim")

  -- Navigation
  use("christoomey/vim-tmux-navigator")
  use("justinmk/vim-sneak")
  use("jesseleite/vim-noh")
  use("karb94/neoscroll.nvim")

  -- Comments
  use("numToStr/Comment.nvim")

  -- Fuzzy finder
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })
  if fn.executable("fzf") == 1 then
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  end

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
  use("onsails/lspkind.nvim")
  use({ "glepnir/lspsaga.nvim", branch = "main" })

  -- AI programming
  use("zbirenbaum/copilot.lua")
  use("zbirenbaum/copilot-cmp")

  -- Formatting & linting
  use("jose-elias-alvarez/null-ls.nvim")
  use("jayp0521/mason-null-ls.nvim")

  -- Syntax Hightlight
  use("nvim-treesitter/nvim-treesitter")

  -- Git
  use("lewis6991/gitsigns.nvim")
  use("tpope/vim-fugitive")
  use("mbbill/undotree")

  -- Indent objects
  use("michaeljsmith/vim-indent-object")

  -- Dependencies
  use("nvim-lua/plenary.nvim")

  if packer_bootstrap then
    packer.sync()
  end
end)
