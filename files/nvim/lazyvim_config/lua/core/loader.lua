local M = {}

local uv = vim.uv or vim.loop

local helpers = require("core.utils.helpers")
local logger = require("core.utils.logger")

-- Get config directories
local function get_config_dirs()
  local dirs = {}

  local global_conf = helpers.get_global_config_dir()
  if global_conf and helpers.is_dir(global_conf) then
    table.insert(dirs, global_conf)
  end

  local root = helpers.get_root()
  local project_conf = root .. "/.nvim"
  if helpers.is_dir(project_conf) then
    table.insert(dirs, project_conf)
  end

  return dirs
end

-- Run init.lua files
function M.run_init()
  for _, dir in ipairs(get_config_dirs()) do
    local init_file = dir .. "/init.lua"
    if not helpers.file_exists(init_file) then
      goto continue
    end

    local ok, _ = helpers.safe_dotfile(init_file, false)
    if ok then
      logger.debug(init_file .. " loaded")
    end

    ::continue::
  end
end

-- Load plugin specs
function M.plugins()
  local specs = {}

  for _, dir in ipairs(get_config_dirs()) do
    local plugins_dir = dir .. "/plugins"
    if uv.fs_stat(plugins_dir) then
      local handle = uv.fs_scandir(plugins_dir)
      if handle then
        while true do
          local name, ftype = uv.fs_scandir_next(handle)
          if not name then
            break
          end

          if ftype == "file" and name:match("%.lua$") then
            local plugin_file = plugins_dir .. "/" .. name
            local ok, plugin = helpers.safe_dotfile(plugin_file, true)
            if ok and plugin then
              logger.debug(plugin_file .. " loaded")
              vim.list_extend(specs, plugin)
            end
          end
        end
      end
    end
  end

  return specs
end

-- Load extras.lua files
function M.extras()
  local extras = {}

  for _, dir in ipairs(get_config_dirs()) do
    local file = dir .. "/extras.lua"
    if not helpers.file_exists(file) then
      goto continue
    end

    local ok, data = helpers.safe_dotfile(file, true)
    if ok and data then
      logger.debug(file .. " loaded")
      for _, entry in ipairs(data) do
        table.insert(extras, entry)
      end
    end

    ::continue::
  end

  return extras
end

return M
