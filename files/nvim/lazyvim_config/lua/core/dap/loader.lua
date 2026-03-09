local M = {}

local fs = require("core.utils.fs")
local logger = require("core.utils.logger").with_source("dap")

local function merge_configs(base, override)
  local by_name = {}
  local order = {}

  for _, cfg in ipairs(base or {}) do
    by_name[cfg.name] = vim.deepcopy(cfg)
    table.insert(order, cfg.name)
  end

  for _, cfg in ipairs(override or {}) do
    if not by_name[cfg.name] then
      table.insert(order, cfg.name)
    end
    by_name[cfg.name] = cfg
  end

  local result = {}
  for _, name in ipairs(order) do
    table.insert(result, by_name[name])
  end
  return result
end

local function load_file(file)
  if not fs.file_exists(file) then
    return nil
  end
  local ok, conf = fs.safe_dotfile(file, true)
  if ok then
    return conf
  else
    logger.warn("failed to load: " .. file)
    return nil
  end
end

function M.setup(dap)
  local core_adapters = require("core.dap.adapters").get_adapters()
  for name, adapter in pairs(core_adapters) do
    dap.adapters[name] = adapter
  end

  local core_configs = require("core.dap.configurations").get_configurations()
  for ft, configs in pairs(core_configs) do
    dap.configurations[ft] = merge_configs(dap.configurations[ft], configs)
  end

  local paths = {}
  local global_dir = fs.get_global_config_dir()
  if global_dir then
    table.insert(paths, global_dir .. "/dap.lua")
  end

  local project_dir = fs.get_project_config_dir()
  if project_dir then
    table.insert(paths, project_dir .. "/dap.lua")
  end

  for _, file in ipairs(paths) do
    local conf = load_file(file)
    if conf then
      if conf.adapters then
        for name, adapter in pairs(conf.adapters) do
          dap.adapters[name] = adapter
        end
      end

      if conf.configurations then
        for ft, configs in pairs(conf.configurations) do
          dap.configurations[ft] = merge_configs(dap.configurations[ft], configs)
        end
      end

      logger.debug("DAP file loaded: " .. file)
    end
  end
end

return M
