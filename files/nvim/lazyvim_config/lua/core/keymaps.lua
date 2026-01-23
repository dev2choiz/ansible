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

M.snacks = {
  -- snacks.terminal
  {
    "<leader>ftT",
    function()
      Snacks.terminal()
    end,
    desc = "Terminal (cwd)",
    mode = { "n" },
  },
  {
    "<leader>ftt",
    function()
      Snacks.terminal(nil, { cwd = LazyVim.root() })
    end,
    desc = "Terminal (Root Dir)",
    mode = { "n" },
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
}

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
}

---@class CoreKeymaps
return M
