local function explorer_open(opts)
  local picker = Snacks.picker.get({ source = "explorer" })
  local explorer = picker and picker[1]

  if not explorer then
    Snacks.picker.explorer(opts)
    return
  end

  if not explorer:is_focused() then
    explorer:focus()
  end
end

local tui_tools_prefix = { "<leader>T", "<M-a>" }

local M = {}

M.keys= {
  -- snacks.terminal
  {
    "<leader>ftT",
    function()
      Snacks.terminal(nil, { esc_esc = true, ctrl_hjkl = true })
    end,
    desc = "Terminal (cwd)",
    mode = { "n", "t" },
  },
  {
    "<leader>ftt",
    function()
      Snacks.terminal(nil, { cwd = LazyVim.root(), esc_esc = true, ctrl_hjkl = true })
    end,
    desc = "Terminal (Root Dir)",
    mode = { "n", "t" },
  },
  {
    "<leader>ftF",
    function()
      Snacks.terminal(nil, { win = { position = "float" } })
    end,
    desc = "floatting terminal",
    mode = { "n" },
  },
  {
    "<leader>ftf",
    function()
      Snacks.terminal(nil, { win = { position = "float" }, cwd = LazyVim.root() })
    end,
    desc = "floatting terminal (Root Dir)",
    mode = { "n" },
  },
  {
    "<leader>E",
    function()
      explorer_open({ root = true })
    end,
    desc = "Explorer Snacks (root dir)",
    mode = { "n", "x" },
  },
  {
    "<leader>e",
    function()
      explorer_open({ root = false })
    end,
    desc = "Explorer Snacks (cwd dir)",
    mode = { "n", "x" },
  },
}

if vim.fn.executable("lazydocker") == 1 then
  for _, prefix in ipairs(tui_tools_prefix) do
    table.insert(M.keys, {
      prefix .. "d",
      function()
        Snacks.terminal.toggle("lazydocker", {
          cwd = vim.fn.expand("%:p:h"),
          auto_close = true,
          interactive = true,
        })
      end,
      desc = "Toggle Lazydocker",
      mode = { "n", "x" },
    })
  end
end

if vim.fn.executable("lazysql") == 1 then
  local lazysql = require("core.lazysql")

  for _, prefix in ipairs(tui_tools_prefix) do
    table.insert(M.keys, {
      prefix .. "ss",
      lazysql.setup,
      desc = "Toggle Lazysql",
      mode = { "n", "x" },
    })
    table.insert(M.keys, {
      prefix .. "sl",
      lazysql.pick,
      desc = "Lazysql Select config",
      mode = { "n", "x" },
    })
  end
end

if vim.fn.executable("resterm") == 1 then
  local resterm = require("core.http.resterm")

  for _, prefix in ipairs(tui_tools_prefix) do
    table.insert(M.keys, {
      prefix .. "hr",
      resterm.run,
      desc = "Toggle Resterm",
      mode = { "n", "x" },
    })
    table.insert(M.keys, {
      prefix .. "hw",
      resterm.select_workspace,
      desc = "Resterm Select Workspace",
      mode = { "n", "x" },
    })
  end
end

if vim.fn.executable("posting") == 1 then
  local posting = require("core.http.posting")

  for _, prefix in ipairs(tui_tools_prefix) do
    table.insert(M.keys, {
      prefix .. "hp",
      posting.run,
      desc = "Toggle Posting",
      mode = { "n", "x" },
    })
    table.insert(M.keys, {
      prefix .. "hc",
      posting.select_collection,
      desc = "Posting Select Collection",
      mode = { "n", "x" },
    })
  end
end

return M