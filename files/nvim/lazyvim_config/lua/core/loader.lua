local M = {}

local uv = vim.uv or vim.loop

---@type CoreUtils
local utils = require("core.utils")

-- Get config directories
local function get_config_dirs()
  local dirs = {}

  local global_conf = utils.getenv_dir("MYNVIM_GLOBAL_CONFIG")
  if global_conf and utils.is_dir(global_conf) then
    table.insert(dirs, global_conf)
  end

  local root = utils.getRoot()
  local project_conf = root .. "/.nvim"
  if utils.is_dir(project_conf) then
    table.insert(dirs, project_conf)
  end

  return dirs
end

-- Run init.lua files
function M.run_init()
  for _, dir in ipairs(get_config_dirs()) do
    local init_file = dir .. "/init.lua"
    if not utils.file_exists(init_file) then
      goto continue
    end

    local ok, _ = utils.safe_dotfile(init_file, false)
    if ok then
      utils.log("DEBUG", init_file .. " loaded")
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
            local ok, plugin = utils.safe_dotfile(plugin_file, true)
            if ok and plugin then
              utils.log("DEBUG", plugin_file .. " loaded")
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
    if not utils.file_exists(file) then
      goto continue
    end

    local ok, data = utils.safe_dotfile(file, true)
    if ok and data then
      utils.log("DEBUG", file .. " loaded")
      vim.tbl_extend("force", extras, data)
    end

    ::continue::
  end

  return extras
end

return M
