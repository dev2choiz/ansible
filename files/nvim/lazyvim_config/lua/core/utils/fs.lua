local logger = require("core.utils.logger")
local uv = vim.uv or vim.loop

---@class CoreUtils
local M = {}

---@return string
function M.get_root()
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

---@param path string
---@param must_return_table boolean
---@return boolean ok
---@return any result
function M.safe_dotfile(path, must_return_table)
  local ok, result_or_err = pcall(dofile, path)
  if not ok then
    logger.error("Failed to load " .. path .. ":\n" .. tostring(result_or_err), true)
    return false, result_or_err
  end

  if must_return_table then
    if type(result_or_err) == "table" then
      return true, result_or_err
    else
      logger.warn(path .. " did not return a table")
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

return M
