local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.conf",
  command = "set filetype=tmux",
  group = augroup("TMUX", {
    clear = true,
  }),
})

-- Add colorcolumn
autocmd({ "BufRead", "BufNewFile" }, {
  command = "set colorcolumn=80",
  group = augroup("ColorColumn", {
    clear = true,
  }),
})

-- Fire FileOpened event
autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
  group = augroup("_file_opened", {
    clear = true,
  }),
  nested = true,
  callback = function(args)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not (vim.fn.expand("%") == "" or buftype == "nofile") then
      vim.api.nvim_del_augroup_by_name("_file_opened")
      vim.cmd("do User FileOpened")
    end
  end,
})

-- Fire DirOpened event
autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
  group = augroup("_dir_opened", {
    clear = true,
  }),
  nested = true,
  callback = function(args)
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    if IsDirectory(bufname) then
      vim.api.nvim_del_augroup_by_name("_dir_opened")
      vim.cmd("do User DirOpened")
      vim.api.nvim_exec_autocmds(args.event, { buffer = args.buf, data = args.data })
    end
  end,
})
