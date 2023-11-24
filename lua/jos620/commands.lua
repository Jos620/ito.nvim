local function command(name, fn)
  vim.cmd("command! " .. name .. " lua " .. fn)
end

command("Harpoon", "require('harpoon.ui').toggle_quick_menu()")
command("HarpoonAdd", "require('harpoon.mark').add_file()")

command("NullLsFormat", "NullLsFormat(vim.api.nvim_get_current_buf())")
