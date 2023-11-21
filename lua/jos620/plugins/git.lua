return {
  { -- Git UI
    {
      "tpope/vim-fugitive",
      cmd = {
        "G",
        "Git",
      },
      event = "VeryLazy",
    },

    {
      "kdheepak/lazygit.nvim",
      event = "User FileOpened",
      cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
  },

  { -- Buffers
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      local status, gitsigns = pcall(require, "gitsigns")
      if not status then
        return
      end

      local setup_git_keymaps = require("jos620.core.keymaps").setup_git_keymaps

      gitsigns.setup({
        on_attach = function(buffer)
          setup_git_keymaps(buffer, gitsigns)
        end,
      })
    end,
  },
}