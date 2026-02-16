local M = {}

local fs = require("core.utils.fs")
local logger = require("core.utils.logger").with_source("dap")

function M.setup(dap)
  local paths = {}

  local global = fs.get_global_config_dir()
  if global then
    table.insert(paths, global .. "/dap.lua")
  end

  table.insert(paths, fs.get_root() .. "/.nvim/dap.lua")

  for _, file in ipairs(paths) do
    if not fs.file_exists(file) then
      goto continue
    end

    local ok, conf = fs.safe_dotfile(file, true)
    if ok then
      if conf.adapters then
        for name, adapter in pairs(conf.adapters) do
          dap.adapters[name] = adapter
        end
      end

      if conf.configurations then
        for ft, configs in pairs(conf.configurations) do
          dap.configurations[ft] = vim.list_extend(vim.deepcopy(configs), dap.configurations[ft] or {})
        end
      end

      logger.debug("file loaded: " .. file, true)
    end

    ::continue::
  end
end

return M
