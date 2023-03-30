local status, bufferline = pcall(require, "bufferline")
if not status then
  return
end

local colors = require("jos620.colors")
local neovide_color = require("jos620.neovide").neovide_color

local normal = {
  fg = colors.gray,
  bg = neovide_color(colors.black),
}

local black = {
  fg = colors.black,
  bg = neovide_color(colors.black),
}

local green = {
  fg = colors.green,
  bg = neovide_color(colors.darkgray),
}

local cyan = {
  fg = colors.cyan,
  bg = neovide_color(colors.black),
}

local blue = {
  fg = colors.blue,
  bg = neovide_color(colors.black),
}

local yellow = {
  fg = colors.yellow,
  bg = neovide_color(colors.black),
}

local red = {
  fg = colors.red,
  bg = neovide_color(colors.black),
}

bufferline.setup({
  options = {
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_alient = "left",
        separator = true,
      },
    },
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

      if string.find(name, "index") or string.find(name, "init") or string.find(name, "style") then
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
        ["spec"] = "",
        ["test"] = "",

        -- Database
        ["repositor"] = "",
      }

      for key, icon in pairs(icons) do
        if string.find(buf.path, key) then
          label = icon .. "|" .. label
        end
      end

      -- ScoreMilk
      if
        string.find(buf.path, "ScoreMilk")
        and string.find(buf.path, "components")
        and not string.find(buf.path, "@mobile")
      then
        label = icons["@desktop"] .. "|" .. label
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
    buffer_selected = {
      fg = colors.white,
      bg = neovide_color(colors.darkgray),
      bold = true,
    },

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
    hint_selected = {
      fg = colors.cyan,
      bg = neovide_color(colors.darkgray),
    },
    hint_diagnostic = cyan,
    hint_diagnostic_visible = cyan,
    hint_diagnostic_selected = {
      fg = colors.cyan,
      bg = neovide_color(colors.darkgray),
    },

    -- Info
    info = blue,
    info_visible = blue,
    info_selected = {
      fg = colors.blue,
      bg = neovide_color(colors.darkgray),
    },
    info_diagnostic = blue,
    info_diagnostic_visible = blue,
    info_diagnostic_selected = {
      fg = colors.blue,
      bg = neovide_color(colors.darkgray),
    },

    -- Warning
    warning = yellow,
    warning_visible = yellow,
    warning_selected = {
      fg = colors.yellow,
      bg = neovide_color(colors.darkgray),
    },
    warning_diagnostic = yellow,
    warning_diagnostic_visible = yellow,
    warning_diagnostic_selected = {
      fg = colors.yellow,
      bg = neovide_color(colors.darkgray),
    },

    -- Error
    error = red,
    error_visible = red,
    error_selected = {
      fg = colors.red,
      bg = neovide_color(colors.darkgray),
    },
    error_diagnostic = red,
    error_diagnostic_visible = red,
    error_diagnostic_selected = {
      fg = colors.red,
      bg = neovide_color(colors.darkgray),
    },

    -- Modified
    modified = yellow,
    modified_visible = yellow,
    modified_selected = {
      fg = colors.yellow,
      bg = neovide_color(colors.darkgray),
    },

    -- Duplicate
    duplicate_selected = {
      fg = colors.gray,
      bg = neovide_color(colors.darkgray),
    },
    duplicate_visible = normal,
    duplicate = normal,

    -- Separators
    separator_selected = black,
    separator_visible = black,
    separator = black,

    -- Indicators
    indicator_selected = green,

    -- Pick
    pick_selected = {
      fg = colors.white,
      bg = neovide_color(colors.darkgray),
      bold = true,
    },
    pick_visible = normal,
    pick = normal,

    -- Offset
    offset_separator = black,
  },
})
