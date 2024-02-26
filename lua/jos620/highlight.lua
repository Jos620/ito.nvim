local utils = require("jos620.utils")
local colors = utils.GetCurrentThemeColors()

utils.SetHighlight("MatchParen", {
  bg = "None",
  fg = colors.red,
})

utils.SetHighlight("Visual", {
  bg = colors.darkgray,
})
