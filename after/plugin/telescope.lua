local telescope_status, telescope = pcall(require, "telescope")
if not telescope_status then
  return
end

telescope.setup()

telescope.load_extension("fzf")
