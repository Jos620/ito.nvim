return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local status, oil = pcall(require, "oil")
    if not status then
      return
    end

    oil.setup({
      default_file_explorer = true,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-b>"] = "actions.select_split",
      },
      view_options = {
        show_hidden = true,
      },
    })
  end,
}
