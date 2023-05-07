local api = vim.api
local augroup = api.nvim_create_augroup
local autocmd = api.nvim_create_autocmd

local tmux_augroup = augroup("TMUX", { clear = true })
autocmd("BufRead, BufNewFile", {
  pattern = "*.conf",
  command = "set filetype=tmux",
  group = tmux_augroup,
})

local auto_format_files = {
  "*.dart",
}

local auto_format_augroup = augroup("AutoFormat", { clear = true })
local auto_format_pattern = table.concat(auto_format_files, ",")

autocmd("BufWritePre", {
  pattern = auto_format_pattern,
  command = "silent! lua vim.lsp.buf.formatting_sync()",
  group = auto_format_augroup,
})
