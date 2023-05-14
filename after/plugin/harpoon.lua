local status, harpoon = pcall(require, "harpoon")
if not status then
  return
end

harpoon.setup()

local keymaps_status, keymaps = pcall(require, "jos620.core.keymaps")
if not keymaps_status then
  return
end

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

keymaps.setup_harpoon_keymaps(mark, ui)
