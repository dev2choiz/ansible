local M = {}

---@type CoreUtils
local utils = require("core.utils")

-- Collect neotest configs (global + project)
local function load_user_configs()
  local configs = {}
  local paths = {}

  -- Global config
  local global = utils.get_global_config_dir()
  if global then
    table.insert(paths, global .. "/neotest.lua")
  end

  -- Project config
  table.insert(paths, utils.getRoot() .. "/.nvim/neotest.lua")

  for _, file in ipairs(paths) do
    if not utils.file_exists(file) then
      goto continue
    end

    local ok, conf = utils.safe_dotfile(file, true)
    if ok and conf then
      utils.log("DEBUG", "[neotest] config loaded: " .. file)
      table.insert(configs, conf)
    end

    ::continue::
  end

  return configs
end

function M.setup(opts)
  opts = opts or {}
  opts.adapters = opts.adapters or {}

  local user_configs = load_user_configs()

  for _, conf in ipairs(user_configs) do
    ----------------------------------------------------------------
    -- adapters
    ----------------------------------------------------------------
    if conf.adapters then
      for name, adapter_opts in pairs(conf.adapters) do
        local ok, adapter = pcall(require, name)
        if ok then
          utils.log("DEBUG", "[neotest] load neotest adapter: " .. name)
          table.insert(opts.adapters, adapter(adapter_opts or {}))
        else
          utils.log("WARN", "[neotest] adapter not found: " .. name)
        end
      end
    end

    ----------------------------------------------------------------
    -- extra config
    ----------------------------------------------------------------
    if conf.config then
      opts = vim.tbl_deep_extend("force", opts, conf.config)
    end

    ----------------------------------------------------------------
    -- exclude adapters
    ----------------------------------------------------------------
    if conf.excludeAdapters then
      for _, excluded in ipairs(conf.excludeAdapters) do
        for i = #opts.adapters, 1, -1 do
          local adapter = opts.adapters[i]
          if adapter.name == excluded then
            utils.log("DEBUG", "[neotest] exclude adapter: " .. excluded)
            table.remove(opts.adapters, i)
          end
        end
      end
    end
  end

  require("neotest").setup(opts)
end

return M
