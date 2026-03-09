local M = {}

function M.get_adapters()
  local adapters = {}

  ------------------------------------------------------------------
  -- GO
  ------------------------------------------------------------------
  adapters.go_launch = {
    type = "server",
    port = "${port}",
    executable = {
      command = "dlv",
      args = { "dap", "-l", "127.0.0.1:${port}" },
    },
  }

  adapters.go = function(callback)
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

  adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = cmd,
      args = { "${port}" },
    },
  }

  return adapters
end

return M
