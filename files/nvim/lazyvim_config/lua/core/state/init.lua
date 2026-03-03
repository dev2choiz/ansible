local engine = require("core.state.engine")

local M = {}

function M.get_transparency()
  local state = engine.create_state("transparency.json")
  return {
    get = state.get,
    set = state.set,
    raw = state.raw,
  }
end

return M
