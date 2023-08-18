return {
  "ThePrimeagen/harpoon",
  lazy = false,
  config = function()
    local status = pcall(require, "harpoon")
    if not status then
      return
    end

    local setup_keymaps = require("jos620.core.keymaps").setup_harpoon_keymaps

    setup_keymaps()
  end,
}
