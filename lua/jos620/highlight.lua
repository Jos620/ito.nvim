local colors = require("jos620.colors")

vim.defer_fn(function()
  local link_to_normal_groups = {
    "NvimTreeFolderName",
    "NvimTreeOpenedFolderName",
    "NvimTreeEmptyFolderName",
    "NvimTreeIndentMarker",
    "NvimTreeRootFolder",
    "packerWorking",
    "harpoonwindow",
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
    "harpoonborder",
  }

  for _, group in ipairs(green_fg_groups) do
    vim.cmd("highlight! " .. group .. " guifg=" .. colors.green)
  end

  local special_highlighted_groups = {
    "NvimTreeSpecialFile",
  }

  for _, group in ipairs(special_highlighted_groups) do
    vim.cmd("highlight! " .. group .. " guifg=" .. colors.green .. " gui=underline,bold")
  end

  vim.cmd("highlight! ColorColumn guibg=" .. colors.darkgray)
  vim.cmd("highlight! BufferLineIndicatorVisible guibg=" .. colors.black)
end, 0)
