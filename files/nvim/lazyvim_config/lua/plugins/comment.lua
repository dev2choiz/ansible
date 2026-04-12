return {
  {
    "numToStr/Comment.nvim",
    opts = {
      mappings = {
        basic = false,
        extra = false,
      },
    },
    config = function(_, opts)
      require("Comment").setup(opts)

      -- With `mappings.basic = false` and `mappings.extra = false` the plugin won't create any mappings
      -- then rewrite the mapping manually, including only the block part (`gb`, `gbc`)
      -- For line part (`gc`, `gcc`), we will use the neovim native functionality
      --
      -- Copied from the source: https://github.com/numToStr/Comment.nvim/blob/master/lua/Comment/init.lua#L98
      local api = require("Comment.api")
      local vvar = vim.api.nvim_get_vvar
      local K = vim.keymap.set

      -- NORMAL mode mappings
      K("n", "gb", "<Plug>(comment_toggle_blockwise)", { desc = "Comment toggle blockwise" })

      K("n", "gbc", function()
        return vvar("count") == 0 and "<Plug>(comment_toggle_blockwise_current)"
          or "<Plug>(comment_toggle_blockwise_count)"
      end, { expr = true, desc = "Comment toggle current block" })

      -- VISUAL mode mappings
      K("x", "gb", "<Plug>(comment_toggle_blockwise_visual)", { desc = "Comment toggle blockwise (visual)" })

      -- Extra Mappings
      K("n", "gcA", api.locked("insert.linewise.eol"), { desc = "Comment insert end of line" })
    end,
  },
}
