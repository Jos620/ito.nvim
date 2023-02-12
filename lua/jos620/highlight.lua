local nvim_tree_hi_groups = {
  "NvimTreeFolderName",
  "NvimTreeOpenedFolderName",
  "NvimTreeEmptyFolderName",
  "NvimTreeIndentMarker",
  "NvimTreeRootFolder",
}

for _, group in ipairs(nvim_tree_hi_groups) do
  vim.cmd("highlight! link " .. group .. " Normal")
end

local nvim_tree_icons = {
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

for _, group in ipairs(nvim_tree_icons) do
  vim.cmd("highlight! " .. group .. " guifg=#4d9375")
end
