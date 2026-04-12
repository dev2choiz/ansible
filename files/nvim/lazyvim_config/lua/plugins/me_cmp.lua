return {
  "Saghen/blink.cmp",
  opts = {
    keymap = {
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
    },

    completion = {
      ghost_text = {
        -- enabled = vim.g.ai_cmp,
        enabled = false,
      },
    },
  },
}
