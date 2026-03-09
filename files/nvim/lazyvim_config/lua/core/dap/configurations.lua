local M = {}

function M.get_configurations()
  local configurations = {}
  ------------------------------------------------------------------
  -- GO
  ------------------------------------------------------------------
  configurations.go = {
    {
      name = "Launch main.go",
      type = "go_launch",
      request = "launch",
      program = "${workspaceFolder}/main.go",
      outputMode = "remote",
    },
    {
      name = "Attach Go (attack to dlv running locally)",
      type = "go",
      request = "attach",
      mode = "remote",
    },
    {
      name = "Attach Go (in docker)",
      type = "go",
      request = "attach",
      mode = "remote",
      substitutePath = {
        {
          from = "${workspaceFolder}",
          to = function()
            return vim.fn.input("Remote path: ", "/app")
          end,
        },
      },
    },
    {
      name = "Attach Go (local process)",
      type = "go_launch",
      request = "attach",
      processId = require("dap.utils").pick_process,
    },
    {
      name = "Debug Go test (current package)",
      type = "go_launch",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
      -- list of available placeholders
      -- https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt#L310
    },
    {
      type = "go_launch",
      name = "Debug Go the nearest test",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
      args = function()
        local test = require("dap-go-ts").closest_test()

        return { "-test.run", "^" .. test.name .. "$" }
      end,
      outputMode = "remote",
    },
  }

  ------------------------------------------------------------------
  -- JS / TS
  ------------------------------------------------------------------
  local js_config = {
    {
      name = "Attach",
      type = "pwa-node",
      request = "attach",
      processId = "pick",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      protocol = "inspector",
      skipFiles = { "<node_internals>/**" },
    },
  }

  for _, ft in ipairs({
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "svelte",
  }) do
    configurations[ft] = vim.deepcopy(js_config)
  end

  return configurations
end

return M
