local helpers = require("core.utils.helpers")
local loader = require("core.loader")
local extras = require("core.extras")

local M = {}

function M.before_setup()
  loader.run_init()
end

function M.before_plugins()
  return helpers.merge_extras(extras, loader.extras())
end

function M.after_plugins()
  return loader.plugins()
end

return M
