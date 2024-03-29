---@class KeymapSetOptions
---@field silent boolean
---@field expr boolean
---@field noremap boolean
---@field nowait boolean
---@field script boolean
---@field unique boolean
---@field buffer number

---@class HighlightSetOptions
---@field fg? string
---@field bg? string
---@field sp? string
---@field blend? integer
---@field bold? boolean
---@field standout? boolean
---@field underline? boolean
---@field undercurl? boolean
---@field underdouble? boolean
---@field underdotted? boolean
---@field underdashed? boolean
---@field strikethrough? boolean
---@field italic? boolean
---@field reverse? boolean
---@field nocombine? boolean
---@field link? string
---@field default? string
---@field ctermfg? string
---@field ctermbg? string
---@field cterm? string

---@class AugroupOptions
---@field clear? boolean

---@alias AugroupFunction fun(name: string, options: AugroupOptions)

---@class AutocmdOptions
---@field group AugroupFunction
---@field nested? boolean
---@field callback? fun(args: AutocmdCallbackArgs)

---@class AutocmdCallbackArgs
---@field event string[]
---@field buf number
---@field data string

---@alias AutocmdFunction fun(event: string[], options: AutocmdOptions)

---@class Colors
---@field white string
---@field black string
---@field darkgray string
---@field gray string
---@field lightgray string
---@field green string
---@field cyan string
---@field blue string
---@field red string
---@field yellow string
---@field orange string

---@alias colorscheme 'default'|'vitesse'
