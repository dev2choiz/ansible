local M = {}

---@type CoreUtils
local utils = require("core.utils")

function M.setup(dap)
  local paths = {}

  local global = utils.getenv_dir("MYNVIM_GLOBAL_CONFIG")
  if global then
    table.insert(paths, global .. "/dap.lua")
  end

  table.insert(paths, utils.getRoot() .. "/.nvim/dap.lua")

  for _, file in ipairs(paths) do
    if not utils.file_exists(file) then
      goto continue
    end

    local ok, conf = utils.safe_dotfile(file, true)
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

      utils.log("DEBUG", "[dap] file loaded: " .. file, true)
    end

    ::continue::
  end
end

return M
