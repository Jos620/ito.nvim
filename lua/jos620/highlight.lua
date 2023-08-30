local colors = require("jos620.core.colors")

local function hi(group, options)
  vim.api.nvim_set_hl(0, group, options)
end

local function link(group, link_to)
  vim.cmd("highlight! link " .. group .. " " .. link_to)
end

local link_to_normal_groups = {
  "NvimTreeFolderName",
  "NvimTreeOpenedFolderName",
  "NvimTreeEmptyFolderName",
  "NvimTreeIndentMarker",
  "NvimTreeRootFolder",
  "packerWorking",
  "harpoonwindow",
  "Directory",
}

for _, group in ipairs(link_to_normal_groups) do
  link(group, "Normal")
end

local green_fg_groups = {
  "NvimTreeFolderIcon",
  "NvimTreeOpenedFolderIcon",
  "NvimTreeClosedFolderIcon",
  "NvimTreeFolderArrowIcon",
  "NvimTreeFileIcon",
  "NvimTreeIndentMarker",
  "NvimTreeGitDirty",
  "NvimTreeGitStaged",
  "NvimTreeGitMerge",
  "NvimTreeGitNew",
  "NvimTreeGitRenamed",
  "NvimTreeGitDeleted",
  "NvimTreeGitIgnored",
  "OilDirIcon",
  "harpoonborder",
}

for _, group in ipairs(green_fg_groups) do
  hi(group, { fg = colors.green })
end

hi("ColorColumn", { bg = colors.darkgray })
hi("BufferLineIndicatorVisible", { bg = colors.black })
hi("NvimTreeSpecialFile", { fg = colors.green, bold = true })
hi("Visual", { bg = colors.darkgray })
hi("MatchParen", { bg = "None", fg = colors.red })
