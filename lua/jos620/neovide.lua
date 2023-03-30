-- Utils
local alpha = function()
  return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
end

local neovide_color = function(default)
  if vim.g.neovide then
    return "None"
  end

  return default
end

-- Window options
vim.o.guifont = "CaskaydiaCove NFM:h20"
vim.g.neovide_remember_window_size = true
vim.g.neovide_refresh_rate = 60

-- Background
vim.g.transparency = 0.65
vim.g.neovide_transparency = 0.65
vim.g.neovide_background_color = "#121212" .. alpha()
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

-- Fix for alt key on MacOS
vim.g.neovide_input_macos_alt_is_meta = true

-- Animations
vim.g.neovide_cursor_animation_length = 0.1

vim.cmd("set nocursorline")

-- Highlighting
vim.cmd("hi lualine_c_normal guibg=None")
vim.cmd("hi Pmenu cterm=None guibg=None")

return {
  neovide_color = neovide_color,
  is_neovide = function()
    return vim.g.neovide ~= nil
  end,
}
