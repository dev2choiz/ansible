local logger = require("core.utils.logger").with_source("keymaps")

local function insert(t, ...)
  local vals = { ... }
  for _, v in ipairs(vals) do
    table.insert(t, v)
  end
end

local tui_tools_prefix = { "<leader>T", "<M-a>" }
local tui_tools_group = {}

for _, prefix in ipairs(tui_tools_prefix) do
  insert(
    tui_tools_group,
    { prefix, group = "TUI tools", mode = { "n", "x" } },
    { prefix .. "s", group = "lazysql", mode = { "n", "x" } },
    { prefix .. "h", group = "http", mode = { "n", "x" } }
  )
end

return {
  spec = {
    { "<leader>a", group = "ai", mode = { "n", "x" } },
    { "<leader>gv", group = "diffview", mode = { "n", "x" } },
    { "<leader>sr", group = "search & replace", mode = { "n", "x" } },
    { "<leader>ft", group = "terminal", mode = { "n", "x" } },
    { "<leader>wS", group = "session", mode = { "n", "x" } },
    { "<leader>m", group = "misc", mode = { "n", "x" } },
    unpack(tui_tools_group),
  },
  keys = {
    { "p", '"_dP', desc = "Paste without overwriting register", mode = { "x" } },

    -- delete without touching the default register
    { "D", '"_d', mode = { "n", "x" }, desc = "Delete (blackhole)" }, -- `D` is the `d` in blackhole version
    { "DD", '"_dd', mode = { "n" }, desc = "Delete line (blackhole)" }, -- `DD` is the `dd` in blackhole version
    { "c", '"_c', mode = { "n", "x" }, desc = "Change (blackhole)" },
    { "C", '"_C', mode = { "n" }, desc = "Change rest of line (blackhole)" },
    { "x", '"_x', mode = { "n", "x" }, desc = "Delete char (blackhole)" },
    { "X", '"_X', mode = { "n" }, desc = "Delete char before cursor (blackhole)" },

    -- workspace diagnostics
    {
      "<leader>xp",
      function()
        vim.diagnostic.reset()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then
          logger.debug("No LSP client attached")
          return
        end
        for _, client in ipairs(clients) do
          require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
        end
      end,
      mode = { "n" },
      desc = "Populate workspace diagnostics",
    },

    -- terminal
    {
      "<F12>",
      "<C-\\><C-n>",
      mode = { "t" },
      desc = "switch to normal mode",
    },

    -- find (override)
    { "<leader>/", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
  },
}
