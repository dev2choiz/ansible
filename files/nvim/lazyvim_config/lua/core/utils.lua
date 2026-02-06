local uv = vim.uv or vim.loop

---@alias CoreLogLevel
---| "DEBUG"
---| "INFO"
---| "WARN"
---| "ERROR"
---| "NONE"

---@class CoreUtils
local M = {}

---@return string
function M.getRoot()
  local ok, result = pcall(vim.fn.systemlist, "git rev-parse --show-toplevel")
  if ok and result[1] and result[1] ~= "" and not result[1]:match("^fatal:") then
    return result[1]
  end
  return vim.fn.getcwd()
end

---@return string?
function M.get_global_config_dir()
  return os.getenv("MYNVIM_GLOBAL_CONFIG")
end

---@return boolean
function M.is_dir(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "directory" or false
end

local log_levels = { DEBUG = 1, INFO = 2, WARN = 3, ERROR = 4, NONE = 5 }

local function get_log_level()
  local env = os.getenv("MYNVIM_LOG_LEVEL") or "INFO"
  return log_levels[env:upper()] or log_levels.INFO
end

local function should_log(level)
  local lv = log_levels[level:upper()] or log_levels.INFO
  return lv >= get_log_level()
end

---@param level CoreLogLevel
---@param msg string
---@param use_notify? boolean
function M.log(level, msg, use_notify)
  if not should_log(level) then
    return
  end

  if use_notify then
    vim.notify(msg, vim.log.levels[level:upper()] or vim.log.levels.INFO)
  else
    vim.api.nvim_echo({ { "[" .. level:upper() .. "] " .. msg } }, true, {})
  end
end

---@param path string
---@param must_return_table boolean
---@return boolean ok
---@return any result
function M.safe_dotfile(path, must_return_table)
  local ok, result_or_err = pcall(dofile, path)
  if not ok then
    M.log("ERROR", "Failed to load " .. path .. ":\n" .. tostring(result_or_err), true)
    return false, result_or_err
  end

  if must_return_table then
    if type(result_or_err) == "table" then
      return true, result_or_err
    else
      M.log("WARN", path .. " did not return a table")
      return false, "invalid-return: expected a table"
    end
  else
    return true, result_or_err
  end
end

---@param path string
---@return boolean
function M.file_exists(path)
  local stat = uv.fs_stat(path)
  return stat ~= nil and stat.type == "file"
end

---@param extras1 table|nil
---@param extras2 table|nil
---@return table
function M.merge_extras(extras1, extras2)
  local result = {}
  local index = {}

  local function add(entry)
    if type(entry) ~= "table" or not entry.import then
      M.log("WARN", "extras entry must define `import`")
      return
    end

    local key = entry.import

    if index[key] then
      -- last one wins
      result[index[key]] = entry
      M.log("DEBUG", "the extras " .. key .. " has been override")
    else
      table.insert(result, entry)
      index[key] = #result
    end
  end

  for _, e in ipairs(extras1 or {}) do
    add(e)
  end

  for _, e in ipairs(extras2 or {}) do
    add(e)
  end

  return result
end

return M
