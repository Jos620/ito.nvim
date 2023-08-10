if vim.fn.executable("fzf") then
  return {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = true,
  }
end

return {}
