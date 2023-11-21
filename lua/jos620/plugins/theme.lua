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
}
