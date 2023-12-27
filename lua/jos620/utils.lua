local M = {}

---Checks if any of the specified files exist in the root directory.
---@param files string[] -- List of file names
---@return boolean       -- True if any file exists
function M.RootHasFile(files)
  local flatFiles = M.Flatten({ files })

  for _, file in ipairs(flatFiles) do
    if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. file) == 1 then
      return true
    end
  end

  return false
end

---Checks if a given file path is within the working directory.
---@param filepath string -- File path to check
---@return boolean        -- True if file is in working directory
function M.FileIsInWorkingDirectory(filepath)
  local cwd = vim.fn.getcwd()

  if filepath:sub(1, #cwd) == cwd then
    return true
  end

  return false
end

---Retrieves the file path associated with a specified mark.
---@param mark string -- Mark to search for
---@return string|nil -- File path or nil if not found
function M.GetFilePathByMark(mark)
  local list = vim.fn.getmarklist()

  for _, item in ipairs(list) do
    if item.mark == "'" .. mark then
      return item.file
    end
  end

  return nil
end

---Merges multiple tables into a single table.
---@param tables table[] -- Tables to merge
---@return table table   -- Merged table
function M.MergeTables(tables)
  local result = {}

  for _, tbl in ipairs(tables) do
    for key, value in pairs(tbl) do
      result[key] = value
    end
  end

  return result
end

---Flattens a nested table structure.
---@param tbl any -- Table to flatten
---@return any[]  -- Flattened table
function M.Flatten(tbl)
  local result = {}

  if type(tbl) ~= "table" then
    return { tbl }
  end

  for _, value in ipairs(tbl) do
    if type(value) == "table" then
      for _, current in ipairs(M.Flatten(value)) do
        table.insert(result, current)
      end
    else
      table.insert(result, value)
    end
  end

  return result
end

---Checks if a buffer name represents a directory.
---@param bufname string -- Buffer name
---@return boolean       -- True if buffer is a directory
function M.IsDirectory(bufname)
  return vim.fn.isdirectory(vim.fn.fnamemodify(bufname, ":p")) == 1
end

---Checks if a specified executable is present.
---@param executable string -- Executable name
---@return boolean          -- True if executable is present
function M.CheckDependency(executable)
  if vim.fn.executable(executable) == 1 then
    return true
  else
    print("Missing dependency: " .. executable)
  end

  return false
end

---Checks if multiple dependencies are present.
---@param executableList string[] -- List of executable names
---@return boolean                -- True if all executables are present
function M.CheckDependencies(executableList)
  for _, executable in ipairs(executableList) do
    if not M.CheckDependency(executable) then
      return false
    end
  end

  return true
end

return M
