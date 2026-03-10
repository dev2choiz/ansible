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
          jestArguments = function(defaultArguments)
            return defaultArguments
          end,
          env = { CI = true },

          -- jestConfigFile = "jest.config.js",
          -- cwd = function(path) return vim.fn.getcwd() end,
          -- isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
        },
        ["neotest-golang"] = {
          go_test_args = {
            "-v",
            "-race",
            "-count=1",
            "-timeout=60s",
            -- "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
          },
          dap_go_enabled = true,
          testify_enabled = true,
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
      require("core.neotest").setup(opts)
    end,
  },
  {
    "andythigpen/nvim-coverage",
    version = "*",
    config = function()
      require("coverage").setup({
        auto_reload = true,
        lang = {
          go = {
            coverage_file = vim.fn.getcwd() .. "/coverage.out",
          },
        },
      })
    end,
  },
}
