return {
  "L3MON4D3/LuaSnip",
  config = function()
    require("core.snippets.loader").setup()

    require("luasnip").config.setup({
      update_events = "TextChanged,TextChangedI",
      enable_autosnippets = true,
    })
  end,
}
