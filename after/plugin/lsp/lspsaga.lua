local status, saga = pcall(require, "lspsaga")
if not status then
  return
end

saga.setup({
  ui = {
    border = "rounded",
  },
  move_in_saga = {
    prev = "<C-k>",
    next = "<C-j>",
  },
  finder = {
    keys = {
      expand_or_jump = "<Return>",
      vsplit = "v",
      split = "b",
    },
  },
  definition = {
    edit = "<Return>",
  },
  symbol_in_winbar = {
    enable = false,
  },
  beacon = {
    enable = false,
  },
  lightbulb = {
    enable = false,
  },
})
