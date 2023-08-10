local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("BufRead, BufNewFile", {
  pattern = "*.conf",
  command = "set filetype=tmux",
  group = augroup("TMUX", {
    clear = true,
  }),
})

-- Fire FileOpened event
autocmd("BufRead, BufWinEnter, BufNewFile", {
  group = augroup("_file_opened", {
    clear = true,
  }),
  nested = true,
  callback = function(args)
    print("FileOpened")
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not (vim.fn.expand("%") == "" or buftype == "nofile") then
      vim.api.nvim_del_augroup_by_name("_file_opened")
      vim.cmd("do User FileOpened")
    end
  end,
})
