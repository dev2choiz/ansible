local M = {}

function M.setup(dap)
  ------------------------------------------------------------------
  -- GO
  ------------------------------------------------------------------
  dap.adapters.go_launch = {
    type = "server",
    port = "${port}",
    executable = {
      command = "dlv",
      args = { "dap", "-l", "127.0.0.1:${port}" },
    },
  }

  dap.adapters.go = function(callback)
    local port = tonumber(vim.fn.input("Delve Port: ", "2345"))
    callback({
      type = "server",
      host = "localhost",
      port = port,
    })
  end

  ------------------------------------------------------------------
  -- JS
  ------------------------------------------------------------------
  local mason = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"
  local cmd = vim.fn.has("win32") == 1 and mason .. "/js-debug-adapter.cmd" or mason .. "/js-debug-adapter"

  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = cmd,
      args = { "${port}" },
    },
  }
end

return M
