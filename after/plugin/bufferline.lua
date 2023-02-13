local status, bufferline = pcall(require, "bufferline")
if not status then
  return
end

local colors = require("jos620.colors")

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
    background = {
      fg = colors.gray,
      bg = colors.black,
    },
    fill = {
      fg = colors.gray,
      bg = colors.black,
    },
    buffer_selected = {
      fg = colors.white,
      bg = colors.darkgray,
      bold = true,
    },
    buffer_visible = {
      fg = colors.gray,
      bg = colors.black,
    },
    separator = {
      fg = colors.black,
      bg = colors.black,
    },
    separator_selected = {
      fg = colors.black,
      bg = colors.black,
    },
    separator_visible = {
      fg = colors.black,
      bg = colors.black,
    },
    indicator_selected = {
      fg = colors.green,
      bg = colors.darkgray,
    },
    modified_selected = {
      fg = colors.yellow,
      bg = colors.darkgray,
    },
    modified_visible = {
      fg = colors.yellow,
      bg = colors.black,
    },
    close_button = {
      fg = colors.gray,
      bg = colors.black,
    },
    close_button_selected = {
      fg = colors.green,
      bg = colors.darkgray,
    },
    close_button_visible = {
      fg = colors.gray,
      bg = colors.black,
    },
    duplicate_selected = {
      fg = colors.gray,
      bg = colors.darkgray,
    },
    duplicate_visible = {
      fg = colors.gray,
      bg = colors.black,
    },
    error_diagnostic = {
      fg = colors.red,
      bg = colors.black,
    },
    error_diagnostic_selected = {
      fg = colors.red,
      bg = colors.darkgray,
    },
    error_diagnostic_visible = {
      fg = colors.red,
      bg = colors.black,
    },
    info_diagnostic = {
      fg = colors.blue,
      bg = colors.black,
    },
    info_diagnostic_selected = {
      fg = colors.blue,
      bg = colors.darkgray,
    },
    info_diagnostic_visible = {
      fg = colors.blue,
      bg = colors.black,
    },
    hint_diagnostic = {
      fg = colors.cyan,
      bg = colors.black,
    },
    hint_diagnostic_selected = {
      fg = colors.cyan,
      bg = colors.darkgray,
    },
    hint_diagnostic_visible = {
      fg = colors.cyan,
      bg = colors.black,
    },
    warning_diagnostic = {
      fg = colors.yellow,
      bg = colors.black,
    },
    warning_diagnostic_selected = {
      fg = colors.yellow,
      bg = colors.darkgray,
    },
    warning_diagnostic_visible = {
      fg = colors.yellow,
      bg = colors.black,
    },
  },
})

local map = vim.keymap.set

map("n", "<Leader>,", ":BufferLineMovePrev<Return>", { silent = true })
map("n", "<Leader>.", ":BufferLineMoveNext<Return>", { silent = true })
