return {
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
