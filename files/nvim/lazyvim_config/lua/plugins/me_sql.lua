return {
  { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  {
    "tpope/vim-dadbod",
    keys = function()
      return require("core.keymaps").vim_dadbod
    end,
  },
}
