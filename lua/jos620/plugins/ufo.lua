return {
  "kevinhwang91/nvim-ufo",
  event = "BufReadPost",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  config = function()
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.opt.foldenable = true

    local status, ufo = pcall(require, "ufo")
    if not status then
      return
    end

    ufo.setup()

    require("jos620.core.keymaps").setup_ufo_keymaps()
  end,
}
