local utils = require("jos620.utils")

utils.CreateAutocmd({ "BufRead", "BufNewFile" }, {
  command = "set colorcolumn=80",
  group = utils.CreateAugroup("ColorColumn", {
    clear = true,
  }),
})

return {
  { -- Treesitter
    "nvim-treesitter/nvim-treesitter",
    cmd = {
      "TSInstall",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
      "TSInstallInfo",
      "TSInstallSync",
      "TSInstallFromGrammar",
    },
    event = "User FileOpened",
    config = function()
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
    end,
  },

  { -- Highlight color codes
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    opts = {
      render = "background",
      enable_named_colors = false,
    },
  },

  { -- Theme (vitesse)
    "2nthony/vitesse.nvim",
    dependencies = {
      "tjdevries/colorbuddy.vim",
    },
    config = function()
      require("vitesse").setup({
        comment_italics = false,
        float_background = true,
        reverse_visual = true,
      })

      vim.cmd("colorscheme vitesse")
    end,
  },
}
