-- local transparency = require("user.transparency")

return {
  "Saghen/blink.cmp",
  version = "*",
  opts = function(_, opts)
    opts.keymap = vim.tbl_extend("force", opts.keymap or {}, {
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return false
          end
          return cmp.select_and_accept()
        end,
        "snippet_forward",
        "fallback",
      },
    })
  end,
}
