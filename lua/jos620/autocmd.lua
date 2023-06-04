local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

function _G.Setup()
  local nvim_tree_status, nvim_tree = pcall(require, "nvim-tree.api")

  if nvim_tree_status and vim.fn.argc() == 0 then
    nvim_tree.tree.open()
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
