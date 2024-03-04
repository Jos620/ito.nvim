local utils = require("jos620.utils")

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazy_path,
  })
end
vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
  spec = {
    import = "jos620.plugins",
  },
  defaults = {
    version = false,
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  debug = false,
})

utils.set_keymap("n", "<Leader>ll", ":Lazy<Return>", "Launch Lazy")

-- Fire FileOpened event
utils.create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
  group = utils.create_augroup("_file_opened", {
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
utils.create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
  group = utils.create_augroup("_dir_opened", {
    clear = true,
  }),
  nested = true,
  callback = function(args)
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    if utils.is_directory(bufname) then
      vim.api.nvim_del_augroup_by_name("_dir_opened")
      vim.cmd("do User DirOpened")
      vim.api.nvim_exec_autocmds(args.event, { buffer = args.buf, data = args.data })
    end
  end,
})
