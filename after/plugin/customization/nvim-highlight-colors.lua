local status, colors = pcall(require, "nvim-highlight-colors")
if not status then
  return
end

colors.setup({
  render = "background",
  enable_named_colors = false,
})
