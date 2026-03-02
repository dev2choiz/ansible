local logger = require("core.utils.logger").with_source("keymaps")

local function insert(t, ...)
  local vals = { ... }
  for _, v in ipairs(vals) do
    table.insert(t, v)
  end
end

---@class CoreKeymaps
local M = {}

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

M.which_key = {
  spec = {
    { "<leader>a", group = "ai", mode = { "n", "x" } },
    { "<leader>gv", group = "diffview", mode = { "n", "x" } },
    { "<leader>sr", group = "search & replace", mode = { "n", "x" } },
    { "<leader>ft", group = "terminal", mode = { "n", "x" } },
    { "<leader>wS", group = "session", mode = { "n", "x" } },
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

M.dap = {
  {
    "<F5>",
    function()
      require("dap").continue()
    end,
    desc = "DAP Continue",
  },
  {
    "<F7>",
    function()
      require("dap").step_into()
    end,
    desc = "DAP Step Into",
  },
  {
    "<F8>",
    function()
      require("dap").step_over()
    end,
    desc = "DAP Step Over",
  },
  {
    "<F12>", -- todo: try to change to <S-F8>
    function()
      require("dap").step_out()
    end,
    desc = "DAP Step Out",
  },
  {
    "<F9>",
    function()
      require("dap").toggle_breakpoint()
    end,
    desc = "DAP Toggle Breakpoint",
  },
  {
    "<S-F9>",
    function()
      require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end,
    desc = "DAP Conditional Breakpoint",
  },
}

M.diffview = {
  { "<leader>gvd", "<cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
  { "<leader>gvc", "<cmd>DiffviewClose<CR>", desc = "Close Diffview" },
  { "<leader>gvh", "<cmd>DiffviewFileHistory %<CR>", desc = "File git history" },
}

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

M.snacks = {
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
    table.insert(M.snacks, {
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
    table.insert(M.snacks, {
      prefix .. "ss",
      lazysql.setup,
      desc = "Toggle Lazysql",
      mode = { "n", "x" },
    })
    table.insert(M.snacks, {
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
    table.insert(M.snacks, {
      prefix .. "hr",
      resterm.run,
      desc = "Toggle Resterm",
      mode = { "n", "x" },
    })
    table.insert(M.snacks, {
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
    table.insert(M.snacks, {
      prefix .. "hp",
      posting.run,
      desc = "Toggle Posting",
      mode = { "n", "x" },
    })
    table.insert(M.snacks, {
      prefix .. "hc",
      posting.select_collection,
      desc = "Posting Select Collection",
      mode = { "n", "x" },
    })
  end
end

M.grug_far = {
  {
    "<leader>srr",
    -- function copied from https://www.lazyvim.org/plugins/editor#grug-farnvim
    function()
      local grug = require("grug-far")
      local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
      grug.open({
        transient = true,
        prefills = {
          filesFilter = ext and ext ~= "" and "*." .. ext or nil,
        },
      })
    end,
    desc = "Search & Replace",
    mode = { "n", "x" },
  },
  {
    "<leader>srf",
    function()
      local grug = require("grug-far")
      local is_file = vim.bo.buftype == ""
      local ext = is_file and vim.fn.expand("%:e")
      local current_file = is_file and vim.fn.expand("%:p") or nil

      grug.open({
        transient = true,
        prefills = {
          filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          paths = current_file,
        },
      })
    end,
    desc = "Search & Replace in this file",
    mode = { "n", "x" },
  },
}

M.auto_session = {
  keys = {
    { "<leader>wSr", "<cmd>AutoSession search<CR>", desc = "Session search" },
    { "<leader>wSs", "<cmd>AutoSession save<CR>", desc = "Save session" },
    { "<leader>wSa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
  },
}

M.vim_dadbod = {
  {
    "<leader>S",
    "<Plug>(DBUI_ExecuteQuery)",
    mode = "n",
    desc = "Execute SQL file",
  },
  {
    "<leader>S",
    "<Plug>(DBUI_ExecuteQuery)",
    mode = "v",
    desc = "Execute SQL selection",
  },
}

function M.config_keymaps()
  Snacks.toggle({
    name = "transparency",
    get = function()
      return require("user.transparency").enabled
    end,
    set = function()
      require("user.transparency").toggle()
    end,
    wk_desc = {
      enabled = "Disable ",
      disabled = "Enable ",
    },
  }):map("<leader>ut")

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "sql",
    callback = function()
      vim.keymap.del("i", "<left>", { buffer = true })
      vim.keymap.del("i", "<right>", { buffer = true })
    end,
  })
end

return M
