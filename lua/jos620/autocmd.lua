local api = vim.api
local augroup = api.nvim_create_augroup
local autocmd = api.nvim_create_autocmd

local tmux_augroup = augroup("TMUX", { clear = true })
autocmd("BufRead, BufNewFile", {
  pattern = "*.conf",
  command = "set filetype=tmux",
  group = tmux_augroup,
})
