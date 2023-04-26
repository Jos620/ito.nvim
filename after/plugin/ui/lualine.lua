local status, lualine = pcall(require, "lualine")
if not status then
  return
end

local colors = require("jos620.colors")
local neovide_color = require("jos620.neovide").neovide_color

lualine.setup({
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    theme = "vitesse",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      {
        "branch",
        color = {
          bg = neovide_color(colors.darkgray),
        },
      },
      {
        "diagnostics",
        color = {
          bg = neovide_color(colors.darkgray),
        },
      },
    },
    lualine_c = {
      {
        "filename",
        color = {
          bg = neovide_color(colors.black),
        },
      },
    },

    lualine_x = {
      {
        "filetype",
        color = {
          bg = neovide_color(colors.black),
        },
      },
    },
    lualine_y = {
      {
        "progress",
        color = {
          bg = neovide_color(colors.darkgray),
        },
      },
    },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
})
