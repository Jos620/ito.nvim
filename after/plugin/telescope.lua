local telescope_status, telescope = pcall(require, "telescope")
if not telescope_status then
  return
end

local actions = require("telescope.actions")

local split_keymaps = {
  ["<C-x>"] = false,
  ["<C-v>"] = actions.select_vertical,
  ["<C-b>"] = actions.select_horizontal,
}

telescope.setup({
  defaults = {
    mappings = {
      i = split_keymaps,
      n = split_keymaps,
    },
  },
})

if vim.fn.executable("fzf") == 1 then
  telescope.load_extension("fzf")
end
