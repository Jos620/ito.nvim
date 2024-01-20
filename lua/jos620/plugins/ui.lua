local colors = require("jos620.core.colors")
local keymaps = require("jos620.core.keymaps")

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
        })
      end,
    },

    {
      "stevearc/dressing.nvim",
    },
  },

  { -- Notifications
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")

      notify.setup({
        background_colour = colors.black,
        timeout = 8000,
      })

      vim.notify = notify

      keymaps.set("n", "<Leader>h", function()
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

      keymaps.set("n", "<Leader>o", ":Oil<Return>", "Toggle Oil")
      keymaps.set("n", "<Leader>O", ":vsplit<Return>:Oil<Return>", "Open oil nvim")
    end,
  },

  { -- Buffers
    "akinsho/bufferline.nvim",
    event = "User FileOpened",
    config = function()
      local bufferline = require("bufferline")

      local normal = {
        fg = colors.gray,
        bg = colors.black,
      }

      local selected = {
        fg = colors.white,
        bg = colors.darkgray,
      }

      local black = {
        fg = colors.black,
        bg = colors.black,
      }

      local gray = {
        fg = colors.gray,
        bg = colors.darkgray,
      }

      local green = {
        fg = colors.green,
        bg = colors.darkgray,
      }

      local cyan = {
        fg = colors.cyan,
        bg = colors.black,
      }

      local cyan_gray = {
        fg = colors.cyan,
        bg = colors.darkgray,
      }

      local blue = {
        fg = colors.blue,
        bg = colors.black,
      }

      local blue_gray = {
        fg = colors.blue,
        bg = colors.darkgray,
      }

      local yellow = {
        fg = colors.yellow,
        bg = colors.black,
      }

      local yellow_gray = {
        fg = colors.yellow,
        bg = colors.darkgray,
      }

      local red = {
        fg = colors.red,
        bg = colors.black,
      }

      local red_gray = {
        fg = colors.red,
        bg = colors.darkgray,
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
          background = normal,
          fill = normal,

          -- Tabs
          tab = normal,
          tab_selected = green,
          tab_close = normal,

          -- Close button
          close_button = normal,
          close_button_visible = normal,
          close_button_selected = green,

          -- Buffers
          buffer_visible = normal,
          buffer_selected = selected,

          -- Numbers
          numbers = normal,
          numbers_visible = normal,
          numbers_selected = green,

          -- General diagnostics
          diagnostic = normal,
          diagnostic_visible = normal,
          diagnostic_selected = green,

          -- Hint
          hint = cyan,
          hint_visible = cyan,
          hint_selected = cyan_gray,
          hint_diagnostic = cyan,
          hint_diagnostic_visible = cyan,
          hint_diagnostic_selected = cyan_gray,

          -- Info
          info = blue,
          info_visible = blue,
          info_selected = blue_gray,
          info_diagnostic = blue,
          info_diagnostic_visible = blue,
          info_diagnostic_selected = blue_gray,

          -- Warning
          warning = yellow,
          warning_visible = yellow,
          warning_selected = yellow_gray,
          warning_diagnostic = yellow,
          warning_diagnostic_visible = yellow,
          warning_diagnostic_selected = yellow_gray,

          -- Error
          error = red,
          error_visible = red,
          error_selected = red_gray,
          error_diagnostic = red,
          error_diagnostic_visible = red,
          error_diagnostic_selected = red_gray,

          -- Modified
          modified = yellow,
          modified_visible = yellow,
          modified_selected = yellow_gray,

          -- Duplicate
          duplicate_selected = gray,
          duplicate_visible = normal,
          duplicate = normal,

          -- Separators
          separator_selected = black,
          separator_visible = black,
          separator = black,

          -- Indicators
          indicator_selected = green,

          -- Pick
          pick_selected = selected,
          pick_visible = normal,
          pick = normal,

          -- Offset
          offset_separator = black,
        },
      })

      keymaps.set("n", "H", ":BufferLineCyclePrev<Return>", "Previous buffer")
      keymaps.set("n", "L", ":BufferLineCycleNext<Return>", "Next buffer")
      keymaps.set("n", "<Leader>,", ":BufferLineMovePrev<Return>", "Move buffer left")
      keymaps.set("n", "<Leader>.", ":BufferLineMoveNext<Return>", "Move buffer right")
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
        keymaps.set("n", "<Leader>sm", ":MaximizerToggle<Return>", "Maximize window")
      end,
    },
  },

  { -- Text navigation
    {
      "justinmk/vim-sneak",
      event = "BufRead",
      config = function()
        vim.g["sneak#prompt"] = ">"

        keymaps.set("n", "f", "<Plug>Sneak_f")
        keymaps.set("n", "F", "<Plug>Sneak_F")
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
