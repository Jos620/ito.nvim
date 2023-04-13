-- Reload configuration
function _G.ReloadConfig()
  -- Reload plugin configuration files
  local function reload_files(path)
    for _, file in ipairs(vim.fn.readdir(path)) do
      local full_path = path .. "/" .. file

      if vim.fn.isdirectory(full_path) == 1 then
        reload_files(full_path)
      elseif file:match("%.lua$") then
        local load = loadfile(full_path)

        if load then
          load()
        else
          print("Error loading plugin file: " .. full_path)
        end
      end
    end
  end
  reload_files(vim.fn.stdpath("config") .. "/after/plugin")

  -- Reload other configuration files
  for name in pairs(package.loaded) do
    if name:match("^jos620") then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)

  -- Reload LSP
  vim.lsp.stop_client(vim.lsp.get_active_clients())

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
