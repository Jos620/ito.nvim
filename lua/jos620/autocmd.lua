local utils = require("jos620.utils")

---@type AugroupFunction
local augroup = vim.api.nvim_create_augroup

---@type AutocmdFunction
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "VimEnter" }, {
  group = augroup("OpenLastFile", {
    clear = true,
  }),
  nested = true,
  callback = function()
    if vim.fn.argc() ~= 0 then
      return
    end

    local last_file_path = utils.GetFilePathByMark("0")
    if last_file_path == nil then
      return
    end

    local is_home = vim.fn.expand("%:p:h") == vim.fn.expand("$HOME")
    local is_git_file = string.find(last_file_path, ".git")
    local is_folder = vim.fn.isdirectory(last_file_path) == 1

    if is_home or is_git_file or is_folder then
      return
    end

    local file_exists = vim.fn.filereadable(last_file_path) == 1

    if file_exists and utils.FileIsInWorkingDirectory(last_file_path) then
      vim.cmd("normal! '0")
      vim.cmd("bdelete #")
    end
  end,
})

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
    if utils.IsDirectory(bufname) then
      vim.api.nvim_del_augroup_by_name("_dir_opened")
      vim.cmd("do User DirOpened")
      vim.api.nvim_exec_autocmds(args.event, { buffer = args.buf, data = args.data })
    end
  end,
})
