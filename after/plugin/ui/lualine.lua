local status, lualine = pcall(require, "lualine")
if not status then
  return
end

lualine.setup({
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    theme = "vitesse",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diagnostics" },
    lualine_c = { "filename" },

    lualine_x = { "filetype" },
    lualine_y = { "progress" },
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
