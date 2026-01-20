---@alias CoreLogLevel
---| "DEBUG"
---| "INFO"
---| "WARN"
---| "ERROR"
---| "NONE"

---@class CoreUtils
---@field getRoot fun(): string
---@field deduplicate fun(tbl: table): table
---@field merge fun(tbl1: table, tbl2: table): table
---@field getenv_dir fun(name: string): string|nil
---@field is_dir fun(path: string): boolean
---@field log fun(level: CoreLogLevel, msg: string, use_notify?: boolean)
---@field safe_dotfile fun(path: string, must_return_table?: boolean): (boolean, any)
---@field file_exists fun(path: string): boolean

local uv = vim.uv or vim.loop

local M = {}

function M.getRoot()
  local ok, result = pcall(vim.fn.systemlist, "git rev-parse --show-toplevel")
  if ok and result[1] and result[1] ~= "" and not result[1]:match("^fatal:") then
    return result[1]
  end
  return vim.fn.getcwd()
end

function M.deduplicate(tbl)
  local seen = {}
  local result = {}

  for _, e in ipairs(tbl) do
    local key = e.import or e[1] or tostring(e)
    if not seen[key] then
      table.insert(result, e)
      seen[key] = true
    end
  end

  return result
end

function M.merge(tbl1, tbl2)
  local combined = {}
  for _, e in ipairs(tbl1) do
    table.insert(combined, e)
  end
  for _, e in ipairs(tbl2) do
    table.insert(combined, e)
  end

  return combined
end

function M.getenv_dir(name)
  local val = os.getenv(name)
  if val and val ~= "" then
    return val
  end
end

function M.is_dir(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "directory"
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

---@type CoreUtils
return M
