local state = require("core.dap.state")

local M = {}

local function register_listener(dap)
  -- use the same key as lazyvim to override the default behavior
  -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/dap/core.lua#L94
  local group = "dapui_config"

  dap.listeners.after.event_initialized[group] = function()
    if state.is_dap_ui_enabled() then
      require("dapui").open()
    else
      require("dapui").close()
      require("dap-view").open()
    end
  end

  dap.listeners.before.event_terminated[group] = function()
    require("dapui").close()
    require("dap-view").close()
  end

  dap.listeners.before.event_exited[group] = function()
    require("dapui").close()
    require("dap-view").close()
  end
end

function M.setup()
  local dap = require("dap")

  register_listener(dap)

  require("core.dap.adapters").setup(dap)
  require("core.dap.configurations").setup(dap)
  require("core.dap.loader").setup(dap)
end

return M
