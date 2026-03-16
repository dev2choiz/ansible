local function js_formatter()
  local root = require("core.utils.fs").get_root()

  if vim.fn.filereadable(root .. "/biome.json") == 1 then
    return { "biome-check" } -- runs formatting, linting and import sorting
  end

  return { "prettier" }
end

return {
  {
    "stevearc/conform.nvim",
    opts = {
      default_format_opts = { lsp_format = "fallback" },
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "golangci-lint" },
        javascript = js_formatter,
        typescript = js_formatter,
        javascriptreact = js_formatter,
        typescriptreact = js_formatter,
        vue = js_formatter,
        json = js_formatter,
        python = { "ruff_format" },
        sh = { "shfmt" },
      },
    },
  },
}
