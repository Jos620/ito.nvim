local gopher_status, gopher = pcall(require, "gopher")
if not gopher_status then
  return
end

gopher.setup({})
