local M = {}

function M.setup()
  local dap = require("dap")

  require("core.dap.adapters").setup(dap)
  require("core.dap.configurations").setup(dap)
  require("core.dap.loader").setup(dap)
end

return M
