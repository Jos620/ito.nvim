function _G.SetupTransparent(is_transparent_str)
  is_transparent_str = is_transparent_str or "false"

  local is_transparent = StringToBoolean(is_transparent_str)

  if is_transparent then
    vim.cmd([[
      TransparentEnable
      set nocul
    ]])
    IsTransparent = true
  else
    vim.cmd([[
      TransparentDisable
      set cul
    ]])
    IsTransparent = false
  end
end

vim.cmd("command! -nargs=1 Transparent lua SetupTransparent(<f-args>)")
vim.cmd("Transparent " .. tostring(IsTransparent))
