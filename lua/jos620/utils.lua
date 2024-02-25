local M = {}

---Create an autocommand
---@type AutocmdFunction
function M.Autocmd(events, options)
  return vim.api.nvim_create_autocmd(events, options)
end

---Create an autocommand group.
---@type AugroupFunction
function M.Augroup(name, options)
  return vim.api.nvim_create_augroup(name, options)
end

---Create a command
---@param name string
---@param lua_script string
function M.Command(name, lua_script)
  vim.cmd("command! " .. name .. " lua " .. lua_script)
end

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

---@class GetFormattersOptions
---@field linters_only? boolean

---Get JavaScript formatters
---@param options? GetFormattersOptions -- Only return linters
---@return string[]                     -- List of linters and formatters
function M.GetJavascriptFormatters(options)
  ---@type GetFormattersOptions
  local defaultOptions = {
    linters_only = false,
  }

  ---@type GetFormattersOptions
  local mergedOptions = M.MergeTables({
    defaultOptions,
    options,
  })

  ---@type string[]
  local linters = {}

  local has_eslint = M.RootHasFile({
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
  })

  if has_eslint then
    table.insert(linters, "eslint_d")
  end

  if mergedOptions.linters_only then
    return linters
  end

  ---@type string[]
  local formatters = {}

  local has_prettier = M.RootHasFile({
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.mjs",
    ".prettierrc.cjs",
    ".prettier.config.js",
    "prettier.config.mjs",
    "prettier.config.cjs",
    ".prettierrc.toml",
  })

  if has_prettier then
    table.insert(formatters, "prettierd")
  end

  return M.Flatten({ linters, formatters })
end

---Get Typescript server path
---@param path string         -- Path to search for typescript server
---@param defaultPath? string -- Default path to use if not found
---@return string             -- Path to typescript server
function M.GetTypescriptServerPath(path, defaultPath)
  local lspconfig = require("lspconfig")

  local global_ts = defaultPath or "/usr/local/lib/node_modules/typescript/lib"
  local found_ts = ""

  local function check_dir(dir_path)
    found_ts = lspconfig.util.path.join(dir_path, "node_modules", "typescript", "lib")
    if lspconfig.util.path.exists(found_ts) then
      return dir_path
    end
  end

  if lspconfig.util.search_ancestors(path, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

---Get CSS formatters
---@param options? GetFormattersOptions -- Only return linters
---@return string[]                     -- List of linters and formatters
function M.GetCSSFormatters(options)
  options = options or { linters_only = false }

  local linters = {}
  local formatters = {
    "prettier",
  }

  local stylelint_configs = {
    ".stylelintrc",
    ".stylelintrc.yaml",
  }

  if M.RootHasFile(stylelint_configs) then
    table.insert(linters, "stylelint")
  end

  if options.linters_only then
    return linters
  end

  return M.Flatten({ linters, formatters })
end

---Check if a buffer is empty
---@param bufnr number -- Buffer number
---@return boolean     -- True if buffer is empty
function M.BufferIsEmpty(bufnr)
  if vim.fn.bufname(bufnr) == "" then
    return true
  end

  return false
end

---Check if a buffer has unsaved changes
---@param bufnr number -- Buffer number
---@return boolean     -- True if buffer has unsaved changes
function M.BufferHasUnsavedChanges(bufnr)
  if vim.fn.getbufvar(bufnr, "&modified") == 1 then
    return true
  end

  return false
end

---Close all empty buffers
---@param force? boolean -- Close all buffers regardless of contents
function M.CloseEmptyBuffers(force)
  for _, bufnr in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
    local is_empty = M.BufferIsEmpty(bufnr.bufnr)
    local has_unsaved_changes = M.BufferHasUnsavedChanges(bufnr.bufnr)

    if is_empty and (force or not has_unsaved_changes) then
      vim.cmd("bdelete " .. bufnr.bufnr)
    end
  end
end

---Get the current theme colors
---@param colorscheme? colorscheme
---@return Colors
function M.GetCurrentThemeColors(colorscheme)
  local theme_colors = require("jos620.theme.colors")

  local current_theme = colorscheme or vim.api.nvim_exec("colorscheme", true)
  if not current_theme or theme_colors[current_theme] == nil then
    current_theme = "default"
  end

  return theme_colors[current_theme]
end

return M
