local utils = require("jos620.utils")

return {
  { -- Git UI
    {
      "tpope/vim-fugitive",
      event = "VeryLazy",
      config = function()
        utils.set_keymap("n", "gs", ":vertical rightbelow Git<Return>", "Open git status")
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
        utils.set_keymap("n", "gL", ":LazyGit<Return>", "Open lazy git")
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
          utils.set_keymap("n", "<Leader>gj", function()
            if vim.wo.diff then
              return "<Leader>gj"
            end

            vim.schedule(function()
              gitsigns.next_hunk()
            end)

            return "<Ignore>"
          end, "Go to next git hunk", utils.merge_tables({ opts, { expr = true } }))

          utils.set_keymap("n", "<Leader>gk", function()
            if vim.wo.diff then
              return "<Leader>gk"
            end

            vim.schedule(function()
              gitsigns.prev_hunk()
            end)

            return "<Ignore>"
          end, "go to previous hunk", utils.merge_tables({ opts, { expr = true } }))

          --- Stage
          utils.set_keymap("n", "<Leader>gS", gitsigns.stage_buffer, "Stage buffer")
          utils.set_keymap("n", "<Leader>gu", gitsigns.undo_stage_hunk, "Undo stage hunk")
          utils.set_keymap("n", "<Leader>td", gitsigns.toggle_deleted, "Toggle deleted sections")

          --- Reset
          utils.set_keymap({ "n", "v" }, "<Leader>gr", gitsigns.reset_hunk, "Reset hunk")
          utils.set_keymap({ "n", "v" }, "<Leader>gR", gitsigns.reset_buffer, "Reset buffer")

          --- Diff
          utils.set_keymap("n", "<Leader>gd", ":Gvdiffsplit<Return>", "Diff buffer")
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

      utils.set_keymap("n", "gm", ":GitMessenger<Return>", "Open git messenger")
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

      utils.set_keymap("n", "<Leader>u", ":UndotreeToggle<Return>", "Toggle Undo Tree")
      utils.set_keymap("n", "<Leader>U", ":UndotreeFocus<Return>", "Focus Undo Tree")
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
      utils.set_keymap("n", "<Leader>lg", ":GhReviewComments<Return>", "Open GitHub review comments")
    end,
  },
}
