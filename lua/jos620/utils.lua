-- Reload configuration
function _G.ReloadConfig()
  for name in pairs(package.loaded) do
    if name:match("^jos620") then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)

  print("Reloaded!")
end

vim.cmd("command! ReloadConfig lua ReloadConfig()")
