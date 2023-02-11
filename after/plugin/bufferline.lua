local status, bufferline = pcall(require, "bufferline")
if not status then
  return
end

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
    fill = {
      bg = "#121212",
    },
    background = {
      fg = "#5c6b5e",
      bg = "#121212",
    },
    buffer_visible = {
      fg = "#292929",
    },
    buffer_selected = {
      bg = "#292929",
    },
    error_visible = {
      fg = "#b49065",
    },
    error_selected = {
      fg = "#a76262",
      bg = "#292929",
    },
    close_button_selected = {
      bg = "#292929",
    },
    separator_visible = {
      bg = "#292929",
    },
    indicator_selected = {
      bg = "#292929",
    },
  },
})

local map = vim.keymap.set

map("n", "<Leader>,", ":BufferLineMovePrev<Return>", { silent = true })
map("n", "<Leader>.", ":BufferLineMoveNext<Return>", { silent = true })
