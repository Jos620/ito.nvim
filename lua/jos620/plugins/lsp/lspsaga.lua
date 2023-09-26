return {
  "glepnir/lspsaga.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  event = "BufReadPre",
  config = function()
    local status, lspsaga = pcall(require, "lspsaga")
    if not status then
      return
    end

    lspsaga.setup({
      ui = {
        border = "rounded",
      },
      move_in_saga = {
        prev = "<C-k>",
        next = "<C-j>",
      },
      finder = {
        keys = {
          toggle_or_open = "<Return>",
          vsplit = "v",
          split = "b",
        },
      },
      definition = {
        edit = "<Return>",
        vsplit = "v",
        split = "b",
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
      hover = {
        open_link = "o",
      },
    })
  end,
}
