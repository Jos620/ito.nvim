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
}
