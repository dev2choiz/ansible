local constants = require("core.constants")

-- This change (`https://github.com/LazyVim/LazyVim/commit/954d8746e5cf1266d93cf4210c00c1506f20423b`) fixes the Biome import issue,
-- but Prettier and Biome formatters can still be active at the same time for the same buffer, which may lead to conflicts.
-- For now, we keep this custom formatter setup.
-- Supported files: https://biomejs.dev/internals/language-support/
local function js_formatter()
  local root = require("core.utils.fs").get_root()

  if vim.fn.filereadable(root .. "/biome.jsonc") == 1 or vim.fn.filereadable(root .. "/biome.json") == 1 then
    return { "biome-check" } -- runs formatting, linting and import sorting
  end

  return { "prettier" }
end

return {
  {
    "stevearc/conform.nvim",
    opts = {
      log_level = vim.log.levels.DEBUG,
      default_format_opts = { timeout_ms = 60000, lsp_format = "fallback" },
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "golangci-lint" },
        javascript = js_formatter,
        typescript = js_formatter,
        javascriptreact = js_formatter,
        typescriptreact = js_formatter,
        vue = js_formatter,
        json = js_formatter,
        jsonc = js_formatter,
        python = { "ruff_format" },
        sh = { "shfmt" },
      },
      formatters = {
        ["biome-check"] = {
          append_args = {
            "--files-max-size=" .. constants.maxFileSize,
          },
          env = {},
        },
      },
    },
  },
}
