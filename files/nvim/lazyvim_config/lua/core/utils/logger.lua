---@alias CoreLogLevel
---| "DEBUG"
---| "INFO"
---| "WARN"
---| "ERROR"
---| "NONE"

---@class CoreLogger
---@field debug fun(msg: string, use_notify?: boolean)
---@field info fun(msg: string, use_notify?: boolean)
---@field warn fun(msg: string, use_notify?: boolean)
---@field error fun(msg: string, use_notify?: boolean)

---@class CoreUtilsLog : CoreLogger
---@field log fun(level: CoreLogLevel, msg: string, use_notify?: boolean)
---@field with_source fun(source: string): CoreLogger
local M = {}

local log_levels = { DEBUG = 1, INFO = 2, WARN = 3, ERROR = 4, NONE = 5 }

local function get_log_level()
  local env = os.getenv("MYNVIM_LOG_LEVEL") or "INFO"
  return log_levels[env:upper()] or log_levels.INFO
end

---@param level CoreLogLevel
local function should_log(level)
  local lv = log_levels[level] or log_levels.INFO
  return lv <= get_log_level()
end

---@param level CoreLogLevel
---@param msg string
---@param use_notify? boolean
local function emit(level, msg, use_notify)
  if not should_log(level) then
    return
  end

  local prefix = "[" .. level .. "] "

  if use_notify then
    vim.notify(prefix .. msg, vim.log.levels[level] or vim.log.levels.INFO)
  else
    vim.api.nvim_echo({ { prefix .. msg } }, true, {})
  end
end

---@param source? string
---@return CoreLogger
local function make_logger(source)
  local function wrap(level)
    return function(msg, use_notify)
      if source then
        msg = string.format("[%s] %s", source, msg)
      end
      emit(level, msg, use_notify)
    end
  end

  ---@type CoreLogger
  return {
    debug = wrap("DEBUG"),
    info = wrap("INFO"),
    warn = wrap("WARN"),
    error = wrap("ERROR"),
  }
end

-- root logger (no source)
local root = make_logger()

M.debug = root.debug
M.info = root.info
M.warn = root.warn
M.error = root.error

---@param source string
---@return CoreLogger
function M.with_source(source)
  source = source:upper()
  return make_logger(source)
end

---@param level CoreLogLevel
---@param msg string
---@param use_notify? boolean
function M.log(level, msg, use_notify)
  emit(level, msg, use_notify)
end

return M
