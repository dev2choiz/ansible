local M = {}

local fs = require("core.utils.fs")
local logger = require("core.utils.logger").with_source("neotest")

-- Collect neotest configs (global + project)
local function load_user_configs()
  local configs = {}
  local paths = {}

  -- Global config
  local global = fs.get_global_config_dir()
  if global then
    table.insert(paths, global .. "/neotest.lua")
  end

  -- Project config
  table.insert(paths, fs.get_root() .. "/.nvim/neotest.lua")

  for _, file in ipairs(paths) do
    if fs.file_exists(file) then
      local ok, conf = fs.safe_dotfile(file, true)
      if ok and conf then
        logger.debug("config loaded: " .. file)
        table.insert(configs, conf)
      end
    end
  end

  return configs
end

function M.get_opts(opts)
  opts = opts or {}
  opts.adapters = opts.adapters or {}

  opts.excludeAdapters = opts.excludeAdapters or {}

  opts.adapters["neotest-jest"] = {
    jestCommand = "npm test --",
    jestArguments = function(defaultArguments)
      return defaultArguments
    end,
    env = { CI = true },
  }

  opts.adapters["neotest-golang"] = {
    go_test_args = {
      "-v",
      "-race",
      "-count=1",
      "-timeout=60s",
    },
    dap_go_enabled = true,
    testify_enabled = true,
  }

  local user_configs = load_user_configs()

  for _, conf in ipairs(user_configs) do
    ----------------------------------------------------------------
    -- adapters
    ----------------------------------------------------------------
    if conf.adapters then
      opts.adapters = vim.tbl_deep_extend("force", opts.adapters, conf.adapters)
    end

    ----------------------------------------------------------------
    -- extra config
    ----------------------------------------------------------------
    if conf.config then
      opts = vim.tbl_deep_extend("force", opts, conf.config)
    end

    ----------------------------------------------------------------
    -- collect excluded adapters
    ----------------------------------------------------------------
    if conf.excludeAdapters then
      vim.list_extend(opts.excludeAdapters, conf.excludeAdapters)
    end
  end

  ----------------------------------------------------------------
  -- exclude adapters
  ----------------------------------------------------------------
  for _, excluded in ipairs(opts.excludeAdapters) do
    if opts.adapters[excluded] ~= nil then
      logger.debug("exclude adapter: " .. excluded)
      opts.adapters[excluded] = nil
    end
  end

  opts.excludeAdapters = nil

  return opts
end

return M
