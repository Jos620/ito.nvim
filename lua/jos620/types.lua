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

--- Augroup options
---@class AugroupOptions
---@field clear? boolean

--- Augroup function
---@alias AugroupFunction fun(name: string, options: AugroupOptions)

--- Autocmd options
---@class AutocmdOptions
---@field group AugroupFunction
---@field nested? boolean
---@field callback? fun(args: AutocmdCallbackArgs)

--- Autocmd callback arguments
---@class AutocmdCallbackArgs
---@field event string[]
---@field buf number
---@field data string

--- Autocmd function
---@alias AutocmdFunction fun(event: string[], options: AutocmdOptions)
