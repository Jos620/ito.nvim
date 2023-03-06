require("jos620.core.options")
require("jos620.core.keymaps")
require("jos620.core.plugins")

require("jos620.utils")
require("jos620.autocmd")
require("jos620.highlight")

if vim.g.neovide then
  require("jos620.neovide")
end
