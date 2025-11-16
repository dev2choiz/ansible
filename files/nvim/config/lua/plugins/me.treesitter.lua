-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = function(_, opts)
    if opts.ensure_installed ~= "all" then
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, {
          "go",
          "gomod",
          "gosum",
          "gowork",
        })
    end
  end,
}
