local utils = require("jos620.utils")
local colors = utils.get_current_theme_colors()

utils.set_highlight("MatchParen", {
  bg = "None",
  fg = colors.red,
})

utils.set_highlight("Visual", {
  bg = colors.darkgray,
})
