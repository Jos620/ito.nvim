-- Load all lua files in a directory
function _G.LoadPath(path)
  for _, file in ipairs(vim.fn.readdir(path)) do
    local full_path = path .. "/" .. file

    if vim.fn.isdirectory(full_path) == 1 then
      LoadPath(full_path)
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

-- Reload configuration
function _G.ReloadConfig()
  LoadPath(vim.fn.stdpath("config") .. "/after/plugin")

  for name in pairs(package.loaded) do
    if name:match("^jos620") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)

  print("Reloaded!")
end

function _G.RootHasFile(...)
  local files = Flatten({ ... })

  for _, file in ipairs(files) do
    if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. file) == 1 then
      return true
    end
  end
end

-- Type conversion
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

-- Table merge
function _G.MergeTable(...)
  local tables = { ... }
  local result = {}

  for _, table in ipairs(tables) do
    for key, value in pairs(table) do
      result[key] = value
    end
  end

  return result
end

function _G.Contains(tbl, value)
  for _, current in pairs(tbl) do
    if current == value then
      return true
    end
  end

  return false
end

function _G.Flatten(tbl)
  local result = {}

  if type(tbl) ~= "table" then
    return { tbl }
  end

  for _, value in ipairs(tbl) do
    if type(value) == "table" then
      for _, current in ipairs(Flatten(value)) do
        table.insert(result, current)
      end
    else
      table.insert(result, value)
    end
  end

  return result
end

-- Range
function _G.IsOneLine(range)
  return range[1] == range[3]
end

function _G.IsRangeEmptyOrInvalid(range)
  if range[3] < range[1] or (IsOneLine(range) and range[4] <= range[2]) then
    return true
  end

  return false
end

-- File / Directory
function _G.IsDirectory(bufname)
  return vim.fn.isdirectory(vim.fn.fnamemodify(bufname, ":p"))
end

-- Dependencies
function _G.CheckDependency(executable)
  if vim.fn.executable(executable) == 1 then
    return true
  else
    print("Missing dependency: " .. executable)
  end

  return false
end

function _G.CheckDependencies(executable_list)
  for _, executable in ipairs(executable_list) do
    if not CheckDependency(executable) then
      return false
    end
  end

  return true
end
