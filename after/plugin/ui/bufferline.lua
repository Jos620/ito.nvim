local status, bufferline = pcall(require, "bufferline")
if not status then
  return
end

local colors = require("jos620.core").colors

local normal = {
  fg = colors.gray,
  bg = colors.black,
}

local green = {
  fg = colors.green,
  bg = colors.darkgray,
}

local black = {
  fg = colors.black,
  bg = colors.black,
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
        label = "/" .. folder
      else
        label = name
      end

      local icons = {
        ["@mobile"] = "󰄜",
        ["@desktop"] = "󰇄",
        ["style"] = "󰏘",
      }

      for key, icon in pairs(icons) do
        if string.find(buf.path, key) then
          label = icon .. " " .. label
        end
      end

      -- ScoreMilk
      if
        string.find(buf.path, "ScoreMilk")
        and string.find(buf.path, "components")
        and not string.find(buf.path, "@mobile")
      then
        label = icons["@desktop"] .. " " .. label
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
      bg = colors.darkgray,
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
    hint = {
      fg = colors.cyan,
      bg = colors.black,
    },
    hint_visible = {
      fg = colors.cyan,
      bg = colors.black,
    },
    hint_selected = {
      fg = colors.cyan,
      bg = colors.darkgray,
    },
    hint_diagnostic = {
      fg = colors.cyan,
      bg = colors.black,
    },
    hint_diagnostic_visible = {
      fg = colors.cyan,
      bg = colors.black,
    },
    hint_diagnostic_selected = {
      fg = colors.cyan,
      bg = colors.darkgray,
    },

    -- Info
    info = {
      fg = colors.blue,
      bg = colors.black,
    },
    info_visible = {
      fg = colors.blue,
      bg = colors.black,
    },
    info_selected = {
      fg = colors.blue,
      bg = colors.darkgray,
    },
    info_diagnostic = {
      fg = colors.blue,
      bg = colors.black,
    },
    info_diagnostic_visible = {
      fg = colors.blue,
      bg = colors.black,
    },
    info_diagnostic_selected = {
      fg = colors.blue,
      bg = colors.darkgray,
    },

    -- Warning
    warning = {
      fg = colors.yellow,
      bg = colors.black,
    },
    warning_visible = {
      fg = colors.yellow,
      bg = colors.black,
    },
    warning_selected = {
      fg = colors.yellow,
      bg = colors.darkgray,
    },
    warning_diagnostic = {
      fg = colors.yellow,
      bg = colors.black,
    },
    warning_diagnostic_visible = {
      fg = colors.yellow,
      bg = colors.black,
    },
    warning_diagnostic_selected = {
      fg = colors.yellow,
      bg = colors.darkgray,
    },

    -- Error
    error = {
      fg = colors.red,
      bg = colors.black,
    },
    error_visible = {
      fg = colors.red,
      bg = colors.black,
    },
    error_selected = {
      fg = colors.red,
      bg = colors.darkgray,
    },
    error_diagnostic = {
      fg = colors.red,
      bg = colors.black,
    },
    error_diagnostic_visible = {
      fg = colors.red,
      bg = colors.black,
    },
    error_diagnostic_selected = {
      fg = colors.red,
      bg = colors.darkgray,
    },

    -- Modified
    modified = {
      fg = colors.yellow,
      bg = colors.black,
    },
    modified_visible = {
      fg = colors.yellow,
      bg = colors.black,
    },
    modified_selected = {
      fg = colors.yellow,
      bg = colors.darkgray,
    },

    -- Duplicate
    duplicate_selected = {
      fg = colors.gray,
      bg = colors.darkgray,
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
      bg = colors.darkgray,
      bold = true,
    },
    pick_visible = normal,
    pick = normal,

    -- Offset
    offset_separator = black,
  },
})
