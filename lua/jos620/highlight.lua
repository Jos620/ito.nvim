local utils = require("jos620.utils")
local colors = utils.GetCurrentThemeColors()

-- Highlights
utils.SetHighlight("BufferLineIndicatorVisible", { bg = colors.black })
utils.SetHighlight("MatchParen", { bg = "None", fg = colors.red })
utils.SetHighlight("Sneak", { bg = colors.yellow, fg = colors.black })

---Groups to link to Normal
---@type string[]
local link_to_normal_groups = {
  "harpoonwindow",
  "Directory",
}

for _, group in ipairs(link_to_normal_groups) do
  utils.LinkHighlightGroups(group, "Normal")
end

---Groups to apply green foreground
---@type string[]
local green_fg_groups = {
  "OilDirIcon",
  "harpoonborder",
  "NoiceCmdlineIcon",
  "NoiceCmdlinePopupBorder",
  "NoiceCmdlinePopupTitle",
}

for _, group in ipairs(green_fg_groups) do
  utils.SetHighlight(group, { fg = colors.green })
end

---Groups to apply darkgray background
---@type string[]
local darkgray_bg_groups = {
  "ColorColumn",
  "Visual",
  "NoiceCmdlinePrompt",
  "NoiceCmdline",
}

for _, group in ipairs(darkgray_bg_groups) do
  utils.SetHighlight(group, { bg = colors.darkgray })
end
