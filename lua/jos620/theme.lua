---@class Theme
---@field colors { [colorscheme]: Colors }
local M = {}

M.colors = {
  vitesse = {
    white = "#ffffff",
    black = "#181818",
    darkgray = "#292929",
    gray = "#c8c5b8",
    lightgray = "#c0caf5",
    green = "#4d9375",
    cyan = "#5eaab5",
    blue = "#6394bf",
    red = "#cb7676",
    yellow = "#e6cc77",
    orange = "#d4976c",
  },
}

M.colors.default = M.colors.vitesse

return M
