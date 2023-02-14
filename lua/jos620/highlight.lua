local colors = require("jos620.colors")

local link_to_normal_groups = {
  "NvimTreeFolderName",
  "NvimTreeOpenedFolderName",
  "NvimTreeEmptyFolderName",
  "NvimTreeIndentMarker",
  "NvimTreeRootFolder",
}

for _, group in ipairs(link_to_normal_groups) do
  vim.cmd("highlight! link " .. group .. " Normal")
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
}

for _, group in ipairs(green_fg_groups) do
  vim.cmd("highlight! " .. group .. " guifg=" .. colors.green)
end