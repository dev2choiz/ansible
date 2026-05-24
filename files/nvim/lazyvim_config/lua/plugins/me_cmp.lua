return {
  "Saghen/blink.cmp",
  version = "1.*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      -- https://github.com/saghen/blink.cmp/blob/main/doc/configuration/keymap.md#enter
      preset = "enter",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },

    completion = {
      ghost_text = {
        -- enabled = vim.g.ai_cmp,
        enabled = false,
      },
      list = { selection = { preselect = false } },
    },
  },
}
