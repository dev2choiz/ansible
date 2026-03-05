local engine = require("core.state.engine")

local M = {}

function M.get_transparency()
  return engine.create_state("transparency.json")
end

function M.get_dap()
  return engine.create_state("dap.json")
end

function M.get_multicursor()
  return engine.create_state("multicursor.json")
end

return M
