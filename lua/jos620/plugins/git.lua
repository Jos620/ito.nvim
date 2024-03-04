local utils = require("jos620.utils")

return {
  { -- Git UI
    {
      "tpope/vim-fugitive",
      event = "VeryLazy",
      config = function()
        utils.SetKeymap("n", "gs", ":vertical rightbelow Git<Return>", "Open git status")
      end,
    },

    {
      "kdheepak/lazygit.nvim",
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
      config = function()
        utils.SetKeymap("n", "gL", ":LazyGit<Return>", "Open lazy git")
      end,
    },
  },

  { -- Buffers
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      local status, gitsigns = pcall(require, "gitsigns")
      if not status then
        return
      end

      gitsigns.setup({
        on_attach = function(buffer)
          local opts = { noremap = true, silent = true, buffer = buffer }

          --- Navigation
          utils.SetKeymap("n", "<Leader>gj", function()
            if vim.wo.diff then
              return "<Leader>gj"
            end

            vim.schedule(function()
              gitsigns.next_hunk()
            end)

            return "<Ignore>"
          end, "Go to next git hunk", utils.MergeTables({ opts, { expr = true } }))

          utils.SetKeymap("n", "<Leader>gk", function()
            if vim.wo.diff then
              return "<Leader>gk"
            end

            vim.schedule(function()
              gitsigns.prev_hunk()
            end)

            return "<Ignore>"
          end, "go to previous hunk", utils.MergeTables({ opts, { expr = true } }))

          --- Stage
          utils.SetKeymap("n", "<Leader>gS", gitsigns.stage_buffer, "Stage buffer")
          utils.SetKeymap("n", "<Leader>gu", gitsigns.undo_stage_hunk, "Undo stage hunk")
          utils.SetKeymap("n", "<Leader>td", gitsigns.toggle_deleted, "Toggle deleted sections")

          --- Reset
          utils.SetKeymap({ "n", "v" }, "<Leader>gr", gitsigns.reset_hunk, "Reset hunk")
          utils.SetKeymap({ "n", "v" }, "<Leader>gR", gitsigns.reset_buffer, "Reset buffer")

          --- Diff
          utils.SetKeymap("n", "<Leader>gd", ":Gvdiffsplit<Return>", "Diff buffer")
        end,
      })
    end,
  },

  { -- Authoring
    "rhysd/git-messenger.vim",
    event = "BufReadPost",
    config = function()
      vim.g.git_messenger_no_default_mappings = true
      vim.g.git_messenger_always_into_popup = true
      vim.g.git_messenger_floating_win_opts = {
        border = "rounded",
      }

      utils.SetKeymap("n", "gm", ":GitMessenger<Return>", "Open git messenger")
    end,
  },

  { -- File history
    "mbbill/undotree",
    cmd = {
      "UndotreeFocus",
      "UndotreeHide",
      "UndotreeShow",
      "UndotreeToggle",
    },
    config = function()
      vim.g.undotree_WindowLayout = 3

      utils.SetKeymap("n", "<Leader>u", ":UndotreeToggle<Return>", "Toggle Undo Tree")
      utils.SetKeymap("n", "<Leader>U", ":UndotreeFocus<Return>", "Focus Undo Tree")
    end,
  },

  { -- PR comments
    "dlvhdr/gh-addressed.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "folke/trouble.nvim",
    },
    cmd = "GhReviewComments",
    keys = { "<Leader>lg" },
    config = function()
      utils.SetKeymap("n", "<Leader>lg", ":GhReviewComments<Return>", "Open GitHub review comments")
    end,
  },
}
