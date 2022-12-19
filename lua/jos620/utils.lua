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

-- Type convertion
function _G.StringToBoolean(original)
  if type(original) == "boolean" then
    return original
  end

  local bool = false

  if original == "true" then
    bool = true
  end

  return bool
end
