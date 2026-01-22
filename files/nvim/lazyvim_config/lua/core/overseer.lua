---@type CoreUtils
local utils = require("core.utils")

local M = {}

local function loadTemplates()
  local templates = {}
  local paths = {}

  -- Global config
  local global = utils.get_global_config_dir()
  if global then
    table.insert(paths, global .. "/overseer.lua")
  end

  -- Project config
  table.insert(paths, utils.getRoot() .. "/.nvim/overseer.lua")

  for _, file in ipairs(paths) do
    if not utils.file_exists(file) then
      goto continue
    end

    local ok, conf = utils.safe_dotfile(file, true)
    if ok and conf then
      for _, tpl in ipairs(conf) do
        table.insert(templates, tpl)
      end
      utils.log("DEBUG", "[overseer] config loaded: " .. file)
    end

    ::continue::
  end

  return templates
end

M.setup = function(opts)
  local overseer = require("overseer")

  overseer.setup(opts)

  local templates = loadTemplates()

  for _, tpl in ipairs(templates) do
    overseer.register_template(tpl)
  end
end

return M
