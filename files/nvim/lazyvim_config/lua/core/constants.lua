local fs = require("core.utils.fs")
local logger = require("core.utils.logger").with_source("constants")

local M = {
  maxFileSize = 10 * 1024 * 1024,
}

local function loadConstants()
  local paths = {}

  -- Global config
  local global = fs.get_global_config_dir()
  if global then
    table.insert(paths, global .. "/constants.lua")
  end

  -- Project config
  table.insert(paths, fs.get_root() .. "/.nvim/constants.lua")

  for _, file in ipairs(paths) do
    if fs.file_exists(file) then
      local ok, conf = fs.safe_dotfile(file, true)
      if ok and type(conf) == "table" then
        M = vim.tbl_deep_extend("force", M, conf)
        logger.debug("config loaded: " .. file)
      end
    end
  end
end

loadConstants()

return M
