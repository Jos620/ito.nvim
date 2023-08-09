return {
  "glepnir/lspsaga.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
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
          expand_or_jump = "<Return>",
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
    })
  end,
}