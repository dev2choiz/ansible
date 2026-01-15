return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>uT"] = {
            function()
              require("user.transparency").toggle()
            end,
            desc = "Toggle transparency",
          },
        },
      },
    },
  },
}