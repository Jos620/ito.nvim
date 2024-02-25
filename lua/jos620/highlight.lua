local utils = require("jos620.utils")
local colors = utils.GetCurrentThemeColors()

utils.SetHighlight("MatchParen", {
  bg = "None",
  fg = colors.red,
})

local darkgray_bg_groups = {
  "ColorColumn",
  "Visual",
}

for _, group in ipairs(darkgray_bg_groups) do
  utils.SetHighlight(group, {
    bg = colors.darkgray,
  })
end
