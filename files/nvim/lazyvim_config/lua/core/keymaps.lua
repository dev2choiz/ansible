local logger = require("core.utils.logger")
---@class CoreKeymaps
local M = {}

M.which_key = {
  spec = {
    {
      mode = { "n", "x" },
      { "<leader>a", group = "ai" },
      { "<leader>gv", group = "diffview" },
      { "<leader>sr", group = "search & replace" },
      { "<leader>ft", group = "terminal" },
      { "<leader>T", group = "tools" },
      { "<leader>Ts", group = "lazysql" },
      { "<leader>Th", group = "http" },
      { "<leader>wS", group = "session" },
    },
  },
  keys = {
    {
      "<Leader>ut",
      function()
        require("user.transparency").toggle()
      end,
      desc = "Toggle transparency",
    },
    { "p", '"_dP', desc = "Paste without overwriting register", mode = { "x" } },

    -- delete without touching the default register
    { "D", '"_d', mode = { "n", "x" }, desc = "Delete (blackhole)" }, -- `D` is the `d` in blackhole version
    { "DD", '"_dd', mode = { "n" }, desc = "Delete line (blackhole)" }, -- `DD` is the `dd` in blackhole version
    { "c", '"_c', mode = { "n", "x" }, desc = "Change (blackhole)" },
    { "C", '"_C', mode = { "n" }, desc = "Change rest of line (blackhole)" },
    { "x", '"_x', mode = { "n", "x" }, desc = "Delete char (blackhole)" },
    { "X", '"_X', mode = { "n" }, desc = "Delete char before cursor (blackhole)" },
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
    "<F8>",
    function()
      require("dap").step_over()
    end,
    desc = "DAP Step Over",
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
  {
    "<F11>",
    function()
      require("dap").step_into()
    end,
    desc = "DAP Step Into",
  },
  {
    "<F12>",
    function()
      require("dap").step_out()
    end,
    desc = "DAP Step Out",
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
    "<leader>e",
    function()
      explorer_open({ root = true })
    end,
    desc = "Explorer Snacks (root dir)",
    mode = { "n", "x" },
  },
  {
    "<leader>E",
    function()
      explorer_open({ cwd = vim.fn.expand("%:p:h") })
    end,
    desc = "Explorer Snacks (cwd dir)",
    mode = { "n", "x" },
  },
}

if vim.fn.executable("lazydocker") == 1 then
  table.insert(M.snacks, {
    "<leader>Td",
    function()
      Snacks.terminal.toggle("lazydocker", {
        cwd = vim.fn.expand("%:p:h"),
        auto_close = true,
        interactive = true,
      })
    end,
    desc = "Lazydocker",
    mode = { "n", "x" },
  })
end

if vim.fn.executable("lazysql") == 1 then
  local lazysql = require("core.lazysql")
  table.insert(M.snacks, {
    "<leader>Tss",
    lazysql.setup,
    desc = "Lazysql",
    mode = { "n", "x" },
  })
  table.insert(M.snacks, {
    "<leader>Tsl",
    lazysql.pick,
    desc = "Select config",
    mode = { "n", "x" },
  })
end

if vim.fn.executable("resterm") == 1 then
  local resterm = require("core.http.resterm")
  table.insert(M.snacks, {
    "<leader>Thr",
    resterm.run,
    desc = "Resterm",
    mode = { "n", "x" },
  })
  table.insert(M.snacks, {
    "<leader>Thw",
    resterm.select_workspace,
    desc = "Resterm Select Workspace",
    mode = { "n", "x" },
  })
end

if vim.fn.executable("posting") == 1 then
  local posting = require("core.http.posting")
  table.insert(M.snacks, {
    "<leader>Thp",
    posting.run,
    desc = "Posting",
    mode = { "n", "x" },
  })
  table.insert(M.snacks, {
    "<leader>Thc",
    posting.select_collection,
    desc = "Posting Select Collection",
    mode = { "n", "x" },
  })
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

return M
