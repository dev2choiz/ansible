return {
  {
    "numToStr/Comment.nvim",
    lazy = true,
    opts = {
      mappings = {
        -- With `mappings.basic = false` and `mappings.extra = false` the plugin won't create any mappings
        -- then rewrite the mapping manually, including only the block part (`gb`, `gbc`)
        -- For line part (`gc`, `gcc`), we will use the neovim / ts-comment.nvim functionality
        basic = false,
        extra = false,
      },
    },
    keys = {
      -- Inspired by the source: https://github.com/numToStr/Comment.nvim/blob/master/lua/Comment/init.lua#L98
      -- NORMAL mode mappings
      {
        "gb",
        "<Plug>(comment_toggle_blockwise)",
        mode = "n",
        desc = "Comment toggle blockwise",
      },
      {
        "gbc",
        function()
          return vim.api.nvim_get_vvar("count") == 0 and "<Plug>(comment_toggle_blockwise_current)"
            or "<Plug>(comment_toggle_blockwise_count)"
        end,
        mode = "n",
        expr = true,
        desc = "Comment toggle current block",
      },
      -- VISUAL mode mappings
      {
        "gb",
        "<Plug>(comment_toggle_blockwise_visual)",
        mode = "x",
        desc = "Comment toggle blockwise (visual)",
      },
      -- Extra Mappings
      {
        "gcA",
        function()
          -- require("Comment.api").locked("insert.linewise.eol")
          require("Comment.api").insert.linewise.eol()
        end,
        mode = "n",
        desc = "Comment insert end of line",
      },
    },
  },
}
