local api = vim.api

local tmux_augroup = api.nvim_create_augroup("TMUX", { clear = true })
api.nvim_create_autocmd("BufRead, BufNewFile", {
  pattern = "*.conf",
  command = "set filetype=tmux",
  group = tmux_augroup,
})
