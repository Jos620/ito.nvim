local status, vitesse = pcall(require, "vitesse")

if not status then
  return
end

vitesse.setup({
  comment_italics = false,
  float_background = true,
  reverse_visual = true,
})

vim.cmd("colorscheme vitesse")
