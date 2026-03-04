local state = require("core.state.init").get_dap()

local M = {}

local ui_plugin_key = "ui_plugin"

function M.is_dap_ui_enabled()
  return state.get(ui_plugin_key, "dapui") == "dapui"
end

function M.toggle_ui_plugin()
  local current = state.get(ui_plugin_key, "dapui")

  if current == "dapui" then
    state.set(ui_plugin_key, "dap-view")
    return "dap-view"
  else
    state.set(ui_plugin_key, "dapui")
    return "dapui"
  end
end

return M
