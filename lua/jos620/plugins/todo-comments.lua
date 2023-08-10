return {
  "folke/todo-comments.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local status, todo = pcall(require, "todo-comments")

    if not status then
      return
    end

    local colors = require("jos620.core.colors")

    todo.setup({
      colors = {
        error = { colors.red },
        warning = { colors.yellow },
        info = { colors.blue },
        hint = { colors.green },
        default = { colors.white },
        test = { colors.cyan },
      },

      keywords = {
        FIX = { color = "error" },
        TODO = { color = "info" },
        HACK = { color = "warning" },
        WARN = { color = "warning" },
        NOTE = { color = "hint" },
      },
    })
  end,
}

-- TODO: Do something
