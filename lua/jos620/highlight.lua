local utils = require("jos620.utils")
local colors = utils.GetCurrentThemeColors()

---Set highlight
---@param group string
---@param options HighlightSetOptions
local function hi(group, options)
  vim.api.nvim_set_hl(0, group, options)
end

---Link two highlight groups
---@param group string
---@param link_to string
local function link(group, link_to)
  vim.cmd("highlight! link " .. group .. " " .. link_to)
end

-- Highlights
hi("BufferLineIndicatorVisible", { bg = colors.black })
hi("MatchParen", { bg = "None", fg = colors.red })
hi("Sneak", { bg = colors.yellow, fg = colors.black })

---Groups to link to Normal
---@type string[]
local link_to_normal_groups = {
  "harpoonwindow",
  "Directory",
}

for _, group in ipairs(link_to_normal_groups) do
  link(group, "Normal")
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
  hi(group, { fg = colors.green })
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
  hi(group, { bg = colors.darkgray })
end
