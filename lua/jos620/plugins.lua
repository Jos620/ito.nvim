-- Auto reloads the plugins
vim.cmd [[
  augroup reload_packer
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

