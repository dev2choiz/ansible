-- local transparency = require("user.transparency")

return {
  "Saghen/blink.cmp",
  version = "*",
  opts = function(_, opts)
    opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
      --[[list = vim.tbl_deep_extend("force", opts.completion and opts.completion.list or {}, {
          selection = vim.tbl_deep_extend("force", opts.completion and opts.completion.list and opts.completion.list.selection or {}, {
              preselect = true,
              auto_insert = false,
          }),
      }),]]

      --[[menu = vim.tbl_deep_extend("force", opts.completion and opts.completion.menu or {}, {
        border = "rounded",
        winblend = transparency.floatLvl,
      }),
      documentation = vim.tbl_deep_extend("force", opts.completion and opts.completion.documentation or {}, {
        window = vim.tbl_deep_extend(
                "force",
                opts.completion and opts.completion.documentation and opts.completion.documentation.window or {},
                {
                  border = "rounded",
                  winblend = transparency.floatLvl,
                }
        ),
      }),]]
    })
    --[[opts.signature = vim.tbl_deep_extend("force", opts.signature or {}, {
      window = vim.tbl_deep_extend("force", opts.signature and opts.signature.window or {}, {
        border = "rounded",
        winblend = transparency.floatLvl,
      }),
    })]]

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
