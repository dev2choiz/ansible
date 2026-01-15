return {
  {
    "leoluz/nvim-dap-go",
    enabled = false,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
    },

    opts = {
      ensure_installed = { "delve", "js", "python" },
    },

    config = function(_, opts)
      require("mason-nvim-dap").setup(opts)

      local dap = require("dap")

      ------------------------------------------------------------------
      -- GOLANG
      ------------------------------------------------------------------
      dap.adapters.go_launch = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      dap.adapters.go = function(callback, config)
        local port = tonumber(vim.fn.input("Delve Port: ", "2345"))
        callback({
          type = "server",
          host = "localhost",
          port = port,
        })
      end

      dap.configurations.go = {
        {
          -- debug main.go
          name = "Launch Go main.go",
          type = "go_launch",
          request = "launch",
          program = "${workspaceFolder}/main.go",
        },
        {
          -- To attach to a `dlv debug`
          name = "Connect Go (remote dlv)",
          type = "go",
          request = "attach",
          mode = "remote",
        },
        {
          -- To attach to a go process
          name = "Attach Go (local process)",
          type = "go_launch",
          request = "attach",
          processId = require("dap.utils").pick_process,
        },
        {
          -- Attach to a `dlv debug` in docker
          name = "Connect Go (Docker / remote dlv)",
          type = "go",
          request = "attach",
          mode = "remote",
          substitutePath = { { from = "${workspaceFolder}", to = "/app" } },
          host = "localhost",
        },
        {
          -- Debug unit test
          name = "Debug Go test (current file)",
          type = "go_launch",
          request = "launch",
          mode = "test",
          program = "${file}",
        }
      }

      ------------------------------------------------------------------
      -- JAVASCRIPT
      ------------------------------------------------------------------
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"
      local js_debug_cmd
      if vim.fn.has("win32") == 1 then
        js_debug_cmd = mason_path .. "/js-debug-adapter.cmd"
      else
        js_debug_cmd = mason_path .. "/js-debug-adapter"
      end

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = js_debug_cmd,
          args = { "${port}" },
        },
      }

      local resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        --"${workspaceFolder}/node_modules/@nestjs/**",
        --"${workspaceFolder}/node_modules/rxjs/**",
        --"!**/node_modules/**",
      }
      local skipFiles = { "<node_internals>/**" }

      local js_config = {
        {
          name = "Attach",
          type = "pwa-node",
          request = "attach",
          processId = "pick",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
          skipFiles = skipFiles,
          resolveSourceMapLocations = resolveSourceMapLocations,
        },
        {
          name = "Launch main.ts",
          type = "pwa-node",
          request = "launch",
          runtimeExecutable = vim.fn.exepath("node"),
          program = "${workspaceFolder}/node_modules/ts-node/dist/bin.js",
          args = { "${workspaceFolder}/src/main.ts", },
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
          skipFiles = skipFiles,
          resolveSourceMapLocations = resolveSourceMapLocations,
        },
        {
          name = "Docker: Attach to Node1",
          type = "pwa-node",
          request = "attach",
          sourceMaps = true,
          port = function()
            return tonumber(vim.fn.input("Port: ", "9229"))
          end,
          address = "localhost",
          localRoot = "${workspaceFolder}",
          remoteRoot = function()
            return vim.fn.input("Remote root: ", "/app")
          end,
          protocol = "inspector",
          sourceMapPathOverrides = {
            ["../src/*"] = "${workspaceFolder}/src/*",
          },
        },
        {
          name = "Debug Jest Test Current file",
          type = "pwa-node",
          request = "launch",
          runtimeExecutable = vim.fn.exepath("node"),
          program = "${workspaceFolder}/node_modules/jest/bin/jest.js",
          args = {
            --"--config", "jest.config.js",
            "--runInBand", "--no-cache", "${file}",
          },
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          skipFiles = skipFiles,
          resolveSourceMapLocations = resolveSourceMapLocations,
        },
      }

      local js_languages = {
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
        "vue",
        "svelte",
      }
      for _, lang in pairs(js_languages) do
        dap.configurations[lang] = vim.deepcopy(js_config)
      end

      -- Load project configs in .nvim/dap.lua if exists
      local project_dap = vim.fn.getcwd() .. "/.nvim/dap.lua"
      if vim.fn.filereadable(project_dap) == 1 then
        local ok, projectConfigs = pcall(dofile, project_dap)
        if ok then
          if projectConfigs.adapters then
            for name, adapter in pairs(projectConfigs.adapters) do
              dap.adapters[name] = adapter
            end
          end
          if projectConfigs.configurations then
            for ft, configs in pairs(projectConfigs.configurations) do
              dap.configurations[ft] = vim.list_extend(dap.configurations[ft] or {}, configs)
            end
          end
          vim.notify("Loaded project DAP config from .nvim/dap.lua")
        end
      end

    end,
  }
}
