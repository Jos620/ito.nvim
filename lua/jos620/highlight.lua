local colors = require("jos620.core.colors")

local function hi(group, options)
  vim.api.nvim_set_hl(0, group, options)
end

local function link(group, link_to)
  vim.cmd("highlight! link " .. group .. " " .. link_to)
end

-- Highlights
hi("BufferLineIndicatorVisible", { bg = colors.black })
hi("MatchParen", { bg = "None", fg = colors.red })
hi("Sneak", { bg = colors.yellow, fg = colors.black })

-- Normal
local link_to_normal_groups = {
  "packerWorking",
  "harpoonwindow",
  "Directory",
}

for _, group in ipairs(link_to_normal_groups) do
  link(group, "Normal")
end

-- Green foreground
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

-- Darkgray background
local darkgray_bg_groups = {
  "ColorColumn",
  "Visual",
  "NoiceCmdlinePrompt",
  "NoiceCmdline",
}

for _, group in ipairs(darkgray_bg_groups) do
  hi(group, { bg = colors.darkgray })
end
