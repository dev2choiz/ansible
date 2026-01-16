return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {  -- todo: https://www.lazyvim.org/extras/lang/yaml
          settings = {
            yaml = {
              schemas = {
                ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.33.5-standalone-strict/all.json"] = "k8s/**/*.yaml",
              },
              validate = true,
              completion = true,
              hover = true,
              format = { enable = true },
              schemas = {
                kubernetes = {
                  "*.yaml",
                },
              },
            },
          },
        },
      }
    },
  },
}

