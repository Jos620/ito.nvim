local status, saga = pcall(require, "lspsaga")
if not status then
  return
end

saga.setup({
  move_in_saga = { prev = "<C-k>", next = "<C-j>" },
  finder_action_keys = {
    open = "<Return>",
  },
  definition_action_keys = {
    edit = "<Return>",
  },
  definition = {
    edit = "<Return>",
  },
})
