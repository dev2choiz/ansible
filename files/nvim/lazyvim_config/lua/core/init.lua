local utils = require("core.utils")
local loader = require("core.loader")
local extras = require("core.extras")

local M = {}

function M.before_setup()
  loader.run_init()
end

function M.before_plugins()
  return utils.deduplicate(utils.merge(extras, loader.extras()))
end

function M.after_plugins()
  return loader.plugins()
end

return M
