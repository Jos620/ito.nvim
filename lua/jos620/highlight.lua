local colors = require("jos620.colors")

vim.defer_fn(function()
  local link_to_normal_groups = {
    "NvimTreeFolderName",
    "NvimTreeOpenedFolderName",
    "NvimTreeEmptyFolderName",
    "NvimTreeIndentMarker",
    "NvimTreeRootFolder",
    "packerWorking",
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
end, 0)
