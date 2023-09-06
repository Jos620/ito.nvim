return {
  "kevinhwang91/nvim-ufo",
  event = "BufReadPost",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  config = function()
    local status, ufo = pcall(require, "ufo")
    if not status then
      return
    end

    ufo.setup()

    require("jos620.core.keymaps").setup_fold_keymaps()
  end,
}
