local has_mason, registry = pcall(require, "mason-registry")
local is_vue_installed = has_mason and registry.is_installed("vue-language-server")
local old_get_pkg_path = LazyVim.get_pkg_path

if not is_vue_installed and old_get_pkg_path then
  LazyVim.get_pkg_path = function(pkg, path, opts)
    if pkg == "vue-language-server" then
      print("vue-language-server not found")
      return ""
    end
    return old_get_pkg_path(pkg, path, opts)
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = {
                ST1000 = false,
              },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                kubernetes = { "*.yaml" },
              },
            },
          },
        },
        lua_ls = {
          init_options = {
            provideFormatter = false,
          },
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                },
              },
            },
          },
        },
      },
    },
  },
}
