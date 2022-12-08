local status, lualine = pcall(require, "lualine")
if not status then
  return
end

local nightfly_theme = require("lualine.themes.nightfly")

local colors = {
  blue = "#65D1FF",
  green = "#3EFFDC",
  violet = "#FF61EF",
  yellow = "#FFDA7B",
  black = "#000000",
}

nightfly_theme.normal.a.bg = colors.blue
nightfly_theme.insert.a.bg = colors.green
nightfly_theme.visual.a.bg = colors.violet
nightfly_theme.command = {
  a = {
    gui = "bold",
    bg = colors.yellow,
    fg = colors.black,
  },
}

lualine.setup({
  options = {
    theme = nightfly_theme,
  },
})
