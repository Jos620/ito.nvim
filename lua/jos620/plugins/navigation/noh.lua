return {
  "jesseleite/vim-noh",
  event = "BufRead",
  config = function()
    vim.cmd("noremap <Plug>NohAfter zz")
  end,
}
