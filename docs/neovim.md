# Customizing LazyVim per Project with a `.nvim` directory

Allows to override plugins, add extra languages, configure DAP adapters, and set project-specific variables.

---

## Directory Structure

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

## Project Initialization (`init.lua`)

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

## Adding Extra LazyVim Modules (`extras.lua`)

Use `extras.lua` to include **additional [LazyVim](https://www.lazyvim.org/extras) extras** for the project:

```lua
return {
  { import = "lazyvim.plugins.extras.lang.python" },  -- add Python support only for this project
}
```

---

## Project-specific Plugins (`plugins/`)

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

## Project-specific DAP Configuration (`dap.lua`)

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

## Overseer (overseer.lua)

```lua
return {
  {
    name = "Start stack",
    builder = function()
      local root_dir = vim.fn.getcwd()

      return {
        cmd = {},
        components = { { "open_output", direction = "dock", on_start = "always", focus = true }, "default" },
        strategy = {
          "orchestrator",
          tasks = {
            {
              cwd = root_dir,
              cmd = { "docker" },
              args = { "compose", "down", "--remove-orphans" },
            },
            {
              cwd = root_dir,
              cmd = { "docker" },
              args = {
                "compose",
                "up",
                "--build",
                "-d",
              },
            },
          },
        },
      }
    end,
  },
}
```

## Lazysql

lazysql can be launched directly from Neovim using:

- a project-specific configuration
- a global configuration
- or Lazysql’s default configuration

Priority order:

1. `.nvim/lazysql_config/lazysql/config.toml` (project)
2. `$MYNVIM_GLOBAL_CONFIG/lazysql_config/lazysql/config.toml` (global)
3. `$XDG_CONFIG_HOME/lazysql/config.toml or ~/.config/lazysql/config.toml` (lazysql default)

The first configuration found is automatically selected.


### Project Lazysql config

Inside your project:
```
my-project/
└─ .nvim/
   └─ lazysql_config/
      └─ lazysql/
         └─ config.toml
```

This file becomes the project Lazysql configuration.
It is selected automatically on launch.

### Global Lazysql config

You can define a shared configuration for all projects:

```bash
export MYNVIM_GLOBAL_CONFIG=~/sources/mynvim
```

Then:
```
~/sources/mynvim/
└─ lazysql_config/
   └─ lazysql/
      └─ config.toml
```


This is used only if no project config exists.

### Default Lazysql config

If neither project nor global configs are found, Lazysql falls back to his default behaviors:
```bash
$XDG_CONFIG_HOME/lazysql/config.toml
```
or:
```bash
~/.config/lazysql/config.toml
```

### Commands
- Launch Lazysql
`<leader>Tss`

-> launches Lazysql using the current configuration.

- Select configuration
`<leader>Tsl`

-> Opens a picker allowing selection of:
project config
global config
Lazysql default


## http

### .nvim/posting.lua
```lua
return {
  collections = {
    "/path/to/the/posting/collection1",
    "/path/to/the/posting/collection2",
  },
}
```

### .nvim/resterm.lua
```lua
return {
  configs = {
    {
      name = "my api",
      workspace = "/path/to/the/resterm/workspace",
      args = {
        "-insecure",
      },
      env = {
        RESTERM_THEMES_DIR = "/path/to/the/themes/directory",
      },
    },
  },
}
```

## Global Configuration

While `.nvim` customizes LazyVim per project, the `MYNVIM_GLOBAL_CONFIG` environment variable can be used to define a **global configuration directory**.  
Settings in this directory apply to all projects, unless they are overridden by a project-specific `.nvim` folder.
