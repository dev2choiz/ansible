return {
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
