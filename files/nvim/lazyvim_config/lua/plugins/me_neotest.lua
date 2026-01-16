return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",

      -- Adapters
      "fredrikaverpil/neotest-golang",
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
    },
    opts = {
      excludeAdapters = {},
      adapters = {
        ["neotest-jest"] = {
          jestCommand = "npm test --",
          jestArguments = function(defaultArguments) return defaultArguments end,
          env = { CI = true },

          -- jestConfigFile = "jest.config.js",
          -- cwd = function(path) return vim.fn.getcwd() end,
          -- isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
        },
        ["neotest-golang"] = {
          go_test_args = { "-v", "-race", "-count=1", "-timeout=60s", },
          dap_go_enabled = true,
        },
      },
      output = { open_on_run = true },
      status = { virtual_text = true },
      quickfix = {
        open = function()
          if LazyVim.has("trouble.nvim") then
            require("trouble").open({ mode = "quickfix", focus = false })
          else
            vim.cmd("copen")
          end
        end,
      },
    },
    config = function(_, opts)
      local neotest = require("neotest")

      local local_path = vim.fn.getcwd() .. "/.nvim/neotest.lua"
      if vim.fn.filereadable(local_path) == 1 then
        local ok, local_conf = pcall(dofile, local_path)
        if ok and type(local_conf) == "table" then
          if local_conf.adapters then
            opts.adapters = vim.tbl_deep_extend("force", opts.adapters, local_conf.adapters)
          end

          if local_conf.config then
            opts = vim.tbl_deep_extend("force", opts, local_conf.config)
          end

          if local_conf.excludeAdapters then
            opts.excludeAdapters = local_conf.excludeAdapters
            for _, name in ipairs(opts.excludeAdapters) do
              opts.adapters[name] = nil
            end
          end
        else
          vim.notify("Invalid .nvim/neotest.lua", vim.log.levels.WARN)
        end
      end

      local ok, lazy_module = pcall(require, "lazyvim.plugins.extras.test.core")
      local cfg_func = nil
      if ok and lazy_module then
        for _, plugin in ipairs(lazy_module) do
          if plugin[1] == "nvim-neotest/neotest" and type(plugin.config) == "function" then
            cfg_func = plugin.config
            break
          end
        end
      end

      if cfg_func then
        cfg_func(_, opts)
      else
        neotest.setup(opts)
      end
    end,
  },
}
