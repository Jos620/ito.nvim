-- Options
vim.g.nightflyItalics = false

local status, _ = pcall(vim.cmd, "colorscheme nightfly")

if not status then
  print("Nightfly colorscheme not found!")
  return
end
