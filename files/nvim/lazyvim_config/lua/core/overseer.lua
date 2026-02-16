local fs = require("core.utils.fs")
local logger = require("core.utils.logger").with_source("overseer")

local M = {}

---@return overseer.TemplateDefinition[]|overseer.TemplateProvider[]
local function loadTemplates()
  local templates = {}
  local paths = {}

  -- Global config
  local global = fs.get_global_config_dir()
  if global then
    table.insert(paths, global .. "/overseer.lua")
  end

  -- Project config
  table.insert(paths, fs.get_root() .. "/.nvim/overseer.lua")

  for _, file in ipairs(paths) do
    if not fs.file_exists(file) then
      goto continue
    end

    local ok, conf = fs.safe_dotfile(file, true)
    if ok and conf then
      for _, tpl in ipairs(conf) do
        table.insert(templates, tpl)
      end
      logger.debug("config loaded: " .. file)
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
