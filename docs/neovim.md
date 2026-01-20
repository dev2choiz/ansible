# Customizing LazyVim per Project with a `.nvim` directory

Allows to override plugins, add extra languages, configure DAP adapters, and set project-specific variables.

---

## 1. Directory Structure

To customize for a project, create a `.nvim` directory at the root of the project:

```
my-project/
└─ .nvim/
   ├─ dap.lua            # Project-specific DAP configurations
   ├─ extras.lua         # Extra LazyVim extras to load
   ├─ init.lua           # Project-specific initializations
   └─ plugins/           # Additional or overridden plugins
      └─ *.lua
```

It's automatically detects and loads files from `.nvim` if they exist.

---

## 2. Project Initialization (`init.lua`)

Use `init.lua` to set up project-specific variables, databases, or any other configuration:

```lua
-- Example: setup project database connections
vim.g.dbs = {
  { name = "local PG", url = "postgres://postgres:postgres@localhost:5432/postgres" },
  { name = "local Redis", url = "redis://127.0.0.1:6379" },
}
```

- Any Lua code to be run before `require("lazy").setup({})` could be placed here.

---

## 3. Adding Extra LazyVim Modules (`extras.lua`)

Use `extras.lua` to include **additional [LazyVim](https://www.lazyvim.org/extras) extras** for the project:

```lua
return {
  { import = "lazyvim.plugins.extras.lang.python" },  -- add Python support only for this project
}
```

---

## 4. Project-specific Plugins (`plugins/`)

You can add plugins that should only load in this project:

```
.nvim/plugins/
├─ ui.lua
```

Example: override colorscheme for the project:

```lua
-- .nvim/plugins/ui.lua
return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
```

---

## 5. Project-specific DAP Configuration (`dap.lua`)

Customize debugging adapters and configurations per project:

```lua
local configurations = {}

local js_config = {
  {
    name = "Launch cli.ts",
    type = "pwa-node",
    request = "launch",
    runtimeExecutable = "node",
    program = "${workspaceFolder}/node_modules/ts-node/dist/bin.js",
    args = {
      "${workspaceFolder}/src/cli.ts",
    },
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
    skipFiles = { "<node_internals>/**" },
    resolveSourceMapLocations = { "${workspaceFolder}/**" },
  },
}

local js_languages = { "typescript", "javascript", "vue" }
for _, lang in pairs(js_languages) do
  configurations[lang] = vim.deepcopy(js_config)
end

return {
  adapters = {
    ["pwa-node-remote"] = {
      type = "server",
      host = "127.0.0.1",
      port = 3000,
    },
  },
  configurations = configurations,
}
```

## 6. Global Configuration

While `.nvim` customizes LazyVim per project, the `MYNVIM_GLOBAL_CONFIG` environment variable can be used to define a **global configuration directory**.  
Settings in this directory apply to all projects, unless they are overridden by a project-specific `.nvim` folder.
