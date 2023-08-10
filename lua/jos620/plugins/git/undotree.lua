return {
  "mbbill/undotree",
  event = "BufRead",
  cmd = {
    "UndotreeFocus",
    "UndotreeHide",
    "UndotreeShow",
    "UndotreeToggle",
  },
  config = function()
    vim.g.undotree_WindowLayout = 3
  end,
}
