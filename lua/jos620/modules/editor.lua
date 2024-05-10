-- Leader key
vim.g.mapleader = " "

-- Tabs & indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Backspace
vim.opt.backspace = "indent,eol,start"

-- Clipboard
vim.opt.clipboard:append("unnamedplus")

-- Scroll
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

-- Update the file when it changes
vim.opt.autoread = true

local utils = require("jos620.utils")

utils.create_autocmd({ "BufReadPost" }, {
  group = utils.create_augroup("clean_empty_buffers", {
    clear = true,
  }),
  pattern = "*",
  callback = function()
    utils.close_empty_buffers()
  end,
})

-- Use "Ç" to open command line
utils.set_keymap({ "n", "v" }, "Ç", ":", "Use ':' with 'Ç'", { noremap = true })

-- Exit insert mode
utils.set_keymap("i", "jk", "<Esc>", "Exit insert mode")
utils.set_keymap("i", "JK", "<Esc>", "Exit insert mode")
utils.set_keymap("i", "Jk", "<Esc>", "Exit insert mode")

-- Scroll sideways
utils.set_keymap("n", "zl", "30zl", "Scroll right")
utils.set_keymap("n", "zh", "30zh", "Scroll left")

-- Do not yank with "X" and "P"
utils.set_keymap({ "n", "v" }, "x", '"_x', "Do not yank with 'x'")
utils.set_keymap({ "n", "v" }, "X", '"_X', "Do not yank with 'X'")
utils.set_keymap("x", "p", '"_dP', "Do not yank with 'p'")

-- Move lines with visual
utils.set_keymap("v", "J", ":m '>+1<Return>gv=gv", "Move lines down")
utils.set_keymap("v", "K", ":m '<-2<Return>gv=gv", "Move lines up")

-- "ie" for "all file"
utils.set_keymap("n", "vie", "ggVG", "Select all file")
utils.set_keymap("n", "cie", "ggcG", "Change all file")
utils.set_keymap("n", "die", "ggdG", "Delete all file")
utils.set_keymap("n", "yie", "ggVGy", "Yank all file")

-- Better navigation on wrapped lines
utils.set_keymap("n", "j", "gj", "Move down")
utils.set_keymap("n", "k", "gk", "Move up")

-- Line indent with visual
utils.set_keymap("v", ">", ">gv", "Indent lines")
utils.set_keymap("v", "<", "<gv", "Unindent lines")

-- Increase / decrease
utils.set_keymap("n", "=", "<C-a>", "Increase")
utils.set_keymap("n", "-", "<C-x>", "Decrease")

local colors = utils.get_current_theme_colors()

utils.set_highlight("MatchParen", {
  bg = "None",
  fg = colors.red,
})

utils.set_highlight("Visual", {
  bg = colors.darkgray,
})

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

      npairs.setup({
        check_ts = true,
      })

      npairs.add_rules({
        Rule("<", ">"):with_pair(
          -- Do not close the pair if the character is the last one in the line
          function()
            ---@diagnostic disable-next-line: deprecated
            local current_line, current_column = unpack(vim.api.nvim_win_get_cursor(0))
            local line_length = string.len(vim.api.nvim_buf_get_lines(0, current_line - 1, current_line, false)[1])
            return current_column + 1 <= line_length
          end
        ),
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
    enabled = false,
    event = "VeryLazy",
    opts = {
      mappings = { "<C-u>", "<C-d>", "zt", "zz", "zb" },
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
