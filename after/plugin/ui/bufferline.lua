local status, bufferline = pcall(require, "bufferline")
if not status then
  return
end

local colors = require("jos620.colors")

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
  },
  highlights = {
    background = normal,
    fill = normal,

    tab = normal,
    tab_selected = green,
    tab_close = normal,

    close_button = normal,
    close_button_visible = normal,
    close_button_selected = green,

    buffer_visible = normal,
    buffer_selected = {
      fg = colors.white,
      bg = colors.darkgray,
      bold = true,
    },

    numbers = normal,
    numbers_visible = normal,
    numbers_selected = green,

    diagnostic = normal,
    diagnostic_visible = normal,
    diagnostic_selected = green,

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

    duplicate_selected = {
      fg = colors.gray,
      bg = colors.darkgray,
    },
    duplicate_visible = normal,
    duplicate = normal,

    separator_selected = black,
    separator_visible = black,
    separator = black,

    indicator_selected = green,

    pick_selected = {
      fg = colors.white,
      bg = colors.darkgray,
      bold = true,
    },
    pick_visible = normal,
    pick = normal,

    offset_separator = black,
  },
})
