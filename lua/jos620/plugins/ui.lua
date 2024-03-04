local utils = require("jos620.utils")

local colors = utils.get_current_theme_colors()

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

        local green_fg_groups = {
          "NoiceCmdlineIcon",
          "NoiceCmdlinePopupBorder",
          "NoiceCmdlinePopupTitle",
        }

        for _, group in ipairs(green_fg_groups) do
          utils.set_highlight(group, {
            fg = colors.green,
          })
        end

        local darkgray_bg_groups = {
          "NoiceCmdlinePrompt",
          "NoiceCmdline",
        }

        for _, group in ipairs(darkgray_bg_groups) do
          utils.set_highlight(group, {
            bg = colors.darkgray,
          })
        end
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
      local bufferline_colors = {
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

          name_formatter = function(buf)
            local modify = vim.fn.fnamemodify

            local name = modify(buf.path, ":t")
            local folder = modify(buf.path, ":h:t")

            local label

            if string.find(name, "index") or string.find(name, "init") then
              label = folder
            else
              label = name
            end

            local icons = {
              -- Environment
              ["@mobile"] = "󰄜",
              ["@desktop"] = "󰇄",

              -- File functions
              ["style"] = "󰏘",

              -- Database
              ["repositor"] = "",
            }

            for key, icon in pairs(icons) do
              if string.find(buf.path, key) and not string.find(label, icon) then
                label = icon .. "|" .. label
              end
            end

            -- ScoreMilk
            if string.find(buf.path, "ScoreMilk") then
              -- Desktop
              if string.find(buf.path, "components") and not string.find(buf.path, "@mobile") then
                label = icons["@desktop"] .. "|" .. label
              end

              -- Style
              if string.find(buf.path, "style") then
                label = icons["style"] .. "|" .. folder
              end
            end

            return label
          end,
        },
        highlights = {
          -- General
          background = bufferline_colors.normal,
          fill = bufferline_colors.normal,

          -- Tabs
          tab = bufferline_colors.normal,
          tab_selected = bufferline_colors.green,
          tab_close = bufferline_colors.normal,

          -- Close button
          close_button = bufferline_colors.normal,
          close_button_visible = bufferline_colors.normal,
          close_button_selected = bufferline_colors.green,

          -- Buffers
          buffer_visible = bufferline_colors.normal,
          buffer_selected = bufferline_colors.selected,

          -- Numbers
          numbers = bufferline_colors.normal,
          numbers_visible = bufferline_colors.normal,
          numbers_selected = bufferline_colors.green,

          -- General diagnostics
          diagnostic = bufferline_colors.normal,
          diagnostic_visible = bufferline_colors.normal,
          diagnostic_selected = bufferline_colors.green,

          -- Hint
          hint = bufferline_colors.cyan,
          hint_visible = bufferline_colors.cyan,
          hint_selected = bufferline_colors.cyan_gray,
          hint_diagnostic = bufferline_colors.cyan,
          hint_diagnostic_visible = bufferline_colors.cyan,
          hint_diagnostic_selected = bufferline_colors.cyan_gray,

          -- Info
          info = bufferline_colors.blue,
          info_visible = bufferline_colors.blue,
          info_selected = bufferline_colors.blue_gray,
          info_diagnostic = bufferline_colors.blue,
          info_diagnostic_visible = bufferline_colors.blue,
          info_diagnostic_selected = bufferline_colors.blue_gray,

          -- Warning
          warning = bufferline_colors.yellow,
          warning_visible = bufferline_colors.yellow,
          warning_selected = bufferline_colors.yellow_gray,
          warning_diagnostic = bufferline_colors.yellow,
          warning_diagnostic_visible = bufferline_colors.yellow,
          warning_diagnostic_selected = bufferline_colors.yellow_gray,

          -- Error
          error = bufferline_colors.red,
          error_visible = bufferline_colors.red,
          error_selected = bufferline_colors.red_gray,
          error_diagnostic = bufferline_colors.red,
          error_diagnostic_visible = bufferline_colors.red,
          error_diagnostic_selected = bufferline_colors.red_gray,

          -- Modified
          modified = bufferline_colors.yellow,
          modified_visible = bufferline_colors.yellow,
          modified_selected = bufferline_colors.yellow_gray,

          -- Duplicate
          duplicate_selected = bufferline_colors.gray,
          duplicate_visible = bufferline_colors.normal,
          duplicate = bufferline_colors.normal,

          -- Separators
          separator_selected = bufferline_colors.black,
          separator_visible = bufferline_colors.black,
          separator = bufferline_colors.black,

          -- Indicators
          indicator_selected = bufferline_colors.green,

          -- Pick
          pick_selected = bufferline_colors.selected,
          pick_visible = bufferline_colors.normal,
          pick = bufferline_colors.normal,

          -- Offset
          offset_separator = bufferline_colors.black,
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
      event = "BufRead",
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
