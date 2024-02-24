local scroll_keys = { "<C-u>", "<C-d>", "zt", "zz", "zb" }

return {
  { -- Hardtime
    "m4xshen/hardtime.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
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
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local conds = require("nvim-autopairs.conds")

      npairs.setup({
        check_ts = true,
      })

      npairs.add_rules({
        Rule("<", ">"):with_pair(conds.after_text("(")),
        Rule("<", ">"):with_pair(conds.after_text(">")),
      })
    end,
  },

  { -- HTML tags
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "rescript",
      "xml",
      "php",
      "markdown",
      "astro",
      "glimmer",
      "handlebars",
      "hbs",
      "templ",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  { -- Surround
    "tpope/vim-surround",
    event = "BufReadPre",
  },

  { -- Folds
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      require("ufo").setup()
    end,
  },

  { -- Comments
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },

  { -- TODO comments
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "TodoLocList", "TodoQuickFix", "TodoTelescope" },
    event = "BufRead",
    config = function()
      local todo_comments = require("todo-comments")
      local utils = require("jos620.utils")

      local colors = utils.GetCurrentThemeColors()

      todo_comments.setup({
        colors = {
          error = { colors.red },
          warning = { colors.yellow },
          info = { colors.yellow },
          hint = { colors.green },
          default = { colors.blue },
          test = { colors.cyan },
        },

        keywords = {
          FIX = { color = "error" },
          TODO = { color = "info" },
          HACK = { color = "warning" },
          WARN = { color = "warning" },
          NOTE = { color = "hint" },
        },
      })
    end,
  },

  { -- Scroll
    "karb94/neoscroll.nvim",
    keys = scroll_keys,
    opts = {
      mappings = scroll_keys,
      hide_cursor = false,
    },
  },

  { -- Indentation object
    "michaeljsmith/vim-indent-object",
    event = "BufReadPre",
  },

  { -- AI development
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
      },
      filetypes = {
        gitcommit = true,
        gitrebase = true,
        hgcommit = true,
        ["*"] = true,
      },
      panel = {
        layout = {
          position = "right",
          ratio = 0.4,
        },
      },
    },
  },

  { -- Remember last position on a file
    "vladdoster/remember.nvim",
    config = function()
      require("remember")
    end,
  },
}
