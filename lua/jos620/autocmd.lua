local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

function _G.Setup()
  if vim.fn.argc() == 0 then
    vim.cmd("NvimTreeOpen")
  end
end

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
