local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("VimEnter", {
  pattern = "*",
  command = "lua Setup()",
})

autocmd("BufRead, BufNewFile", {
  pattern = "*.conf",
  command = "set filetype=tmux",
  group = augroup("TMUX", {
    clear = true,
  }),
})
