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
  },
})

local map = vim.keymap.set

map("n", "<Leader>,", ":BufferLineMovePrev<Return>", { silent = true })
map("n", "<Leader>.", ":BufferLineMoveNext<Return>", { silent = true })
