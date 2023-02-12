local telescope_status, telescope = pcall(require, "telescope")
if not telescope_status then
  return
end

telescope.setup()

if vim.fn.executable("fzf") == 1 then
  telescope.load_extension("fzf")
end
