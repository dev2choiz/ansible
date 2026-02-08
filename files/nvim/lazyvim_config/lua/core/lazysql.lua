local helpers = require("core.utils.helpers")
local logger = require("core.utils.logger").with_source("lazysql")

local config_dirname = "lazysql_config"
local conf_rel_path = "/lazysql/config.toml"

---@class CoreLazysql
local M = {}

local function get_all_configs()
  local paths = {}
  local results = {}
  local global = helpers.get_global_config_dir()

  table.insert(paths, helpers.get_root() .. "/.nvim/" .. config_dirname)
  if global then
    table.insert(paths, global .. "/" .. config_dirname)
  end

  for _, path in ipairs(paths) do
    local toml = path .. conf_rel_path
    if helpers.is_dir(path) and helpers.file_exists(toml) then
      table.insert(results, path)
    end
  end

  return results
end

local function init_current_config()
  local configs = get_all_configs()
  if #configs > 0 then
    return configs[1]
  end

  local xdg = os.getenv("XDG_CONFIG_HOME")
  local default_paths = {}
  if xdg then
    table.insert(default_paths, xdg .. conf_rel_path)
  end
  table.insert(default_paths, vim.fn.expand("~/.config" .. conf_rel_path))

  for _, p in ipairs(default_paths) do
    if helpers.file_exists(p) then
      return "default"
    end
  end

  return nil
end

M.current_config = init_current_config()

function M.pick()
  local configs = get_all_configs()
  local picker_items = {}

  for i, path in ipairs(configs) do
    table.insert(picker_items, {
      idx = i,
      text = path,
      value = path,
      file = path .. conf_rel_path,
    })
  end

  local default_file = ""
  do
    local xdg = os.getenv("XDG_CONFIG_HOME")
    local fallback_paths = {}
    if xdg then
      table.insert(fallback_paths, xdg .. conf_rel_path)
    end
    table.insert(fallback_paths, vim.fn.expand("~/.config" .. conf_rel_path))

    for _, p in ipairs(fallback_paths) do
      if helpers.file_exists(p) then
        default_file = p
        break
      end
    end
  end

  table.insert(picker_items, {
    idx = #picker_items + 1,
    text = "default (~/.config/lazysql)",
    value = "default",
    file = default_file,
  })

  if #picker_items == 0 then
    logger.warn("no configs found")
    return
  end

  Snacks.picker({
    title = "Select Lazysql config",
    items = picker_items,
    format = function(item)
      return { { item.text:gsub(vim.fn.getcwd(), "."), "String" } }
    end,
    confirm = function(_, item)
      if item.value == "default" then
        M.current_config = nil
      else
        M.current_config = item.value
      end
      logger.info("current config set to: " .. vim.inspect(M.current_config))
    end,
  })
end

function M.setup()
  local cmd = "lazysql"
  if M.current_config then
    local cfg_path = M.current_config
    if cfg_path == "default" then
      local xdg = os.getenv("XDG_CONFIG_HOME")
      if xdg and helpers.file_exists(xdg .. conf_rel_path) then
        cfg_path = xdg
      else
        cfg_path = vim.fn.expand("~/.config")
      end
    end
    cmd = string.format("XDG_CONFIG_HOME=%q lazysql", cfg_path)
  end

  logger.debug(cmd)

  Snacks.terminal.toggle(cmd, { auto_close = true, interactive = true })
end

return M
