local M = {}

function M.setup(dap)
  ------------------------------------------------------------------
  -- GO
  ------------------------------------------------------------------
  dap.configurations.go = {
    {
      name = "Launch main.go",
      type = "go_launch",
      request = "launch",
      program = "${workspaceFolder}/main.go",
    },
    {
      name = "Attach Go (remote dlv)",
      type = "go",
      request = "attach",
      mode = "remote",
    },
    {
      name = "Attach Go (local process)",
      type = "go_launch",
      request = "attach",
      processId = require("dap.utils").pick_process,
    },
    {
      name = "Debug Go test (current file)",
      type = "go_launch",
      request = "launch",
      mode = "test",
      program = "${file}",
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
    dap.configurations[ft] = vim.deepcopy(js_config)
  end
end

return M
