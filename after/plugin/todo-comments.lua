local status, todo = pcall(require, "todo-comments")

if not status then
  return
end

local colors = require("jos620.colors")

todo.setup({
  keywords = {
    FIX = { color = "error" },
    TODO = { color = "info" },
    HACK = { color = "warning" },
    WARN = { color = "warning" },
    NOTE = { color = "hint" },
  },

  color = {
    error = { colors.red },
    warning = { colors.yellow },
    info = { colors.blue },
    hint = { colors.green },
    default = { colors.white },
    test = { colors.cyan },
  },
})
