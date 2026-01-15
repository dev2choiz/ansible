-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  "leoluz/nvim-dap-go",
  config = true,
  opts = function(_, opts)
      opts.dap_configurations = {
        {
          type = "go",
          name = "Attach remote (/sources :2345)",
          mode = "remote",
          request = "attach",
          port = "2345",
          substitutePath = {
            { from = '${workspaceFolder}', to = '/sources' },
          },
        },
      }
  end
}
