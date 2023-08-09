local colors = require("jos620.colors")

local function hi(group, options)
  vim.api.nvim_set_hl(0, group, options)
end

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
    hi(group, { fg = colors.green })
  end

  local special_highlighted_groups = {
    "NvimTreeSpecialFile",
  }

  for _, group in ipairs(special_highlighted_groups) do
    hi(group, {
      fg = colors.green,
      bold = true,
    })
  end

  hi("ColorColumn", { bg = colors.darkgray })
  hi("BufferLineIndicatorVisible", { bg = colors.black })
end, 0)
