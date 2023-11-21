return {
  { -- Hardtime
    "m4xshen/hardtime.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    event = "User FileOpened",
    opts = {
      max_time = 2000,
      max_count = 5,
      disable_mouse = false,
      restricted_keys = {
        ["j"] = {},
        ["k"] = {},
      },
    },
  },

  { -- Pairs
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  { -- Folds
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      require("ufo").setup()
      require("jos620.core.keymaps").setup_fold_keymaps()
    end,
  },

  { -- Comments
    "numToStr/Comment.nvim",
    event = "BufRead",
    opts = {},
  },
}
