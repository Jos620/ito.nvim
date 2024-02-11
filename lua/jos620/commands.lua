---Create a command
---@param name string
---@param lua_script string
local function command(name, lua_script)
  vim.cmd("command! " .. name .. " lua " .. lua_script)
end

command("Harpoon", "require('harpoon.ui').toggle_quick_menu()")
command("HarpoonAdd", "require('harpoon.mark').add_file()")
