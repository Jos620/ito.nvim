local utils = require("jos620.utils")

local colors = utils.get_current_theme_colors()

-- Split window
utils.set_keymap("n", "<Leader>sv", "<C-w>v", "Split window vertically")
utils.set_keymap("n", "<Leader>sb", "<C-w>s", "Split window horizontally")
utils.set_keymap("n", "<Leader>se", "<C-w>=", "Equalize windows")

utils.set_keymap("n", "<Leader>Sv", "<C-w>t<C-w>H", "Change split orientation to horizontal")
utils.set_keymap("n", "<Leader>Sb", "<C-w>t<C-w>K", "Change split orientation to vertical")

-- Buffers
utils.set_keymap("n", "<Leader>%", function()
  vim.cmd("only")
end, "Close other windows")
utils.set_keymap("n", "<Leader>q", ":quit<Return>", "Quit window")
utils.set_keymap("n", "<Leader>x", ":close<Return>", "Close window")
utils.set_keymap("n", "<Leader>c", ":bdelete<Return>", "Close buffer")
utils.set_keymap("n", "<Leader>C", ":b# <bar> bd#<Return>", "Close buffer, without closing the window")

-- Fold
utils.set_keymap("n", "<Leader>z", "$V%zf", "Create fold")

utils.set_highlight({ "CursorLine", "ColorColumn" }, {
  bg = colors.black,
})

return {
  { -- Better UI for Neovim
    {
      "folke/noice.nvim",
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      config = function()
        require("noice").setup({
          routes = {
            { -- Hide "No information available" message
              filter = {
                event = "notify",
                find = "No information available",
              },
              opts = {
                skip = true,
              },
            },
            { -- Hide search count
              filter = {
                event = "msg_show",
                kind = "search_count",
              },
              opts = {
                skip = true,
              },
            },
            { -- Hide written message
              filter = {
                event = "msg_show",
                find = "written$",
              },
              opts = {
                skip = true,
              },
            },
            { -- Hide Sneak messages
              filter = {
                event = "msg_show",
                find = "^" .. (vim.g["sneak#prompt"] or ">") .. ".*",
              },
              opts = {
                skip = true,
              },
            },
            { -- Hide Gitsigns hunk messages
              filter = {
                event = "msg_show",
                find = "^Hunk %d+ of %d+$",
              },
              opts = {
                skip = true,
              },
            },
            { -- Hide search loop warning
              filter = {
                event = "msg_show",
                find = "^search hit %a+, continuing at %a+$",
              },
              opts = {
                skip = true,
              },
            },
          },
          presets = {
            lsp_doc_border = true,
          },
          lsp = {
            signature = {
              auto_open = {
                enabled = false,
              },
            },
          },
        })

        utils.set_highlight({
          "NoiceCmdlineIcon",
          "NoiceCmdlinePopupBorder",
          "NoiceCmdlinePopupTitle",
        }, {
          fg = colors.green,
        })

        utils.set_highlight({
          "NoiceCmdlinePrompt",
          "NoiceCmdline",
        }, {
          bg = colors.darkgray,
        })
      end,
    },

    {
      "stevearc/dressing.nvim",
      event = "VeryLazy",
    },
  },

  { -- Notifications
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")

      notify.setup({
        background_colour = colors.black,
        timeout = 8000,
        top_down = false,
      })

      vim.notify = notify

      utils.set_keymap("n", "<Leader>h", function()
        vim.cmd([[nohlsearch]])
        vim.cmd([[echom '']])
        notify.dismiss()
      end, "Clear screen")
    end,
  },

  { -- File explorer
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-b>"] = "actions.select_split",
          ["<C-h>"] = false,
          ["<C-j>"] = false,
          ["<C-k>"] = false,
          ["<C-l>"] = false,
        },
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
        },
      })

      local split_shortcuts = {
        ["<Leader>o"] = "vsplit",
        ["<Leader>O"] = "split",
      }

      for key, action in pairs(split_shortcuts) do
        utils.set_keymap("n", key, function()
          vim.cmd(action)
          vim.cmd("Oil")
          utils.close_empty_buffers()
        end, "Open file explorer")
      end

      utils.set_highlight("OilDirIcon", { fg = colors.green })
      utils.link_highlight_groups("Directory", "Normal")
    end,
  },

  { -- Buffers
    "akinsho/bufferline.nvim",
    event = "User FileOpened",
    config = function()
      local bufferline = require("bufferline")

      ---@type table<string, HighlightSetOptions>
      local highlight_colors = {
        normal = {
          fg = colors.gray,
          bg = colors.black,
        },
        selected = {
          fg = colors.white,
          bg = colors.darkgray,
        },
        black = {
          fg = colors.black,
          bg = colors.black,
        },
        gray = {
          fg = colors.gray,
          bg = colors.darkgray,
        },
        green = {
          fg = colors.green,
          bg = colors.darkgray,
        },
        cyan = {
          fg = colors.cyan,
          bg = colors.black,
        },
        cyan_gray = {
          fg = colors.cyan,
          bg = colors.darkgray,
        },
        blue = {
          fg = colors.blue,
          bg = colors.black,
        },
        blue_gray = {
          fg = colors.blue,
          bg = colors.darkgray,
        },
        yellow = {
          fg = colors.yellow,
          bg = colors.black,
        },
        yellow_gray = {
          fg = colors.yellow,
          bg = colors.darkgray,
        },
        red = {
          fg = colors.red,
          bg = colors.black,
        },
        red_gray = {
          fg = colors.red,
          bg = colors.darkgray,
        },
      }

      bufferline.setup({
        options = {
          style_preset = bufferline.style_preset.no_bold,
          close_command = "bdelete! %d",
          diagnostics = "nvim_lsp",
          separator_style = {
            "",
            "",
          },
        },
        highlights = {
          -- General
          background = highlight_colors.normal,
          fill = highlight_colors.normal,

          -- Tabs
          tab = highlight_colors.normal,
          tab_selected = highlight_colors.green,
          tab_close = highlight_colors.normal,

          -- Close button
          close_button = highlight_colors.normal,
          close_button_visible = highlight_colors.normal,
          close_button_selected = highlight_colors.green,

          -- Buffers
          buffer_visible = highlight_colors.normal,
          buffer_selected = highlight_colors.selected,

          -- Numbers
          numbers = highlight_colors.normal,
          numbers_visible = highlight_colors.normal,
          numbers_selected = highlight_colors.green,

          -- General diagnostics
          diagnostic = highlight_colors.normal,
          diagnostic_visible = highlight_colors.normal,
          diagnostic_selected = highlight_colors.green,

          -- Hint
          hint = highlight_colors.cyan,
          hint_visible = highlight_colors.cyan,
          hint_selected = highlight_colors.cyan_gray,
          hint_diagnostic = highlight_colors.cyan,
          hint_diagnostic_visible = highlight_colors.cyan,
          hint_diagnostic_selected = highlight_colors.cyan_gray,

          -- Info
          info = highlight_colors.blue,
          info_visible = highlight_colors.blue,
          info_selected = highlight_colors.blue_gray,
          info_diagnostic = highlight_colors.blue,
          info_diagnostic_visible = highlight_colors.blue,
          info_diagnostic_selected = highlight_colors.blue_gray,

          -- Warning
          warning = highlight_colors.yellow,
          warning_visible = highlight_colors.yellow,
          warning_selected = highlight_colors.yellow_gray,
          warning_diagnostic = highlight_colors.yellow,
          warning_diagnostic_visible = highlight_colors.yellow,
          warning_diagnostic_selected = highlight_colors.yellow_gray,

          -- Error
          error = highlight_colors.red,
          error_visible = highlight_colors.red,
          error_selected = highlight_colors.red_gray,
          error_diagnostic = highlight_colors.red,
          error_diagnostic_visible = highlight_colors.red,
          error_diagnostic_selected = highlight_colors.red_gray,

          -- Modified
          modified = highlight_colors.yellow,
          modified_visible = highlight_colors.yellow,
          modified_selected = highlight_colors.yellow_gray,

          -- Duplicate
          duplicate_selected = highlight_colors.gray,
          duplicate_visible = highlight_colors.normal,
          duplicate = highlight_colors.normal,

          -- Separators
          separator_selected = highlight_colors.black,
          separator_visible = highlight_colors.black,
          separator = highlight_colors.black,

          -- Indicators
          indicator_selected = highlight_colors.green,

          -- Pick
          pick_selected = highlight_colors.selected,
          pick_visible = highlight_colors.normal,
          pick = highlight_colors.normal,

          -- Offset
          offset_separator = highlight_colors.black,
        },
      })

      utils.set_keymap("n", "H", ":BufferLineCyclePrev<Return>", "Previous buffer")
      utils.set_keymap("n", "L", ":BufferLineCycleNext<Return>", "Next buffer")
      utils.set_keymap("n", "<Leader>,", ":BufferLineMovePrev<Return>", "Move buffer left")
      utils.set_keymap("n", "<Leader>.", ":BufferLineMoveNext<Return>", "Move buffer right")

      utils.set_highlight("BufferLineIndicatorVisible", { bg = colors.black })
    end,
  },

  { -- Lualine
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local mode_color = {
        normal = colors.green,
        insert = colors.orange,
        visual = colors.yellow,
        replace = colors.red,
        command = colors.blue,
        inactive = colors.darkgray,
      }

      local theme = {}

      for mode, color in pairs(mode_color) do
        theme[mode] = {
          a = { bg = color, fg = colors.black },
          b = { bg = colors.black, fg = color },
          c = { bg = colors.black, fg = colors.gray },
        }
      end

      require("lualine").setup({
        options = {
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          theme = theme,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            {
              "branch",
              color = {
                bg = colors.darkgray,
              },
            },
            {
              "diagnostics",
              color = {
                bg = colors.darkgray,
              },
            },
          },
          lualine_c = {},

          lualine_x = {
            {
              "filetype",
              color = {
                bg = colors.black,
              },
            },
          },
          lualine_y = {
            {
              "progress",
              color = {
                bg = colors.darkgray,
              },
            },
          },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },

  { -- Window navigation
    {
      "christoomey/vim-tmux-navigator",
      lazy = false,
    },

    {
      "szw/vim-maximizer",
      event = "VeryLazy",
      cmd = { "MaximizerToggle" },
      config = function()
        utils.set_keymap("n", "<Leader>sm", ":MaximizerToggle<Return>", "Maximize window")
      end,
    },
  },

  { -- Text navigation
    {
      "justinmk/vim-sneak",
      event = "VeryLazy",
      config = function()
        vim.g["sneak#prompt"] = ">"

        utils.set_keymap("n", "f", "<Plug>Sneak_f")
        utils.set_keymap("n", "F", "<Plug>Sneak_F")
        utils.set_highlight("Sneak", { bg = colors.yellow, fg = colors.black })
      end,
    },

    { -- Clear highlights
      "jesseleite/vim-noh",
      event = "BufRead",
      config = function()
        vim.cmd("noremap <Plug>NohAfter zz")
      end,
    },
  },
}
