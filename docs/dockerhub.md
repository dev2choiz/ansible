# Neovim Full Dev Environment in Docker

Complete Neovim setup running inside Docker with Go and Node.js preinstalled.

This image provides a ready-to-use development environment focused on Go + modern Neovim workflows.

## Features

- Fully configured Neovim (LSP, DAP, Treesitter, plugins, keymaps)
- Go toolchain + common Go dev tools (delve, golangci-lint, etc.)
- Node.js for Neovim ecosystem (LSP servers, formatters, linters)
- Ready-to-use terminal environment (zsh, tmux, fonts)
- CLI utilities (lazygit, lazysql, lazydocker, eza, yazi, resterm)

Designed as a **portable development container**:

> pull → run → code

No local setup required.

---

## Use cases

- Reproducible Neovim setup  
- Isolated Go + Node development environment  
- Fast onboarding on new machines  
- Personal daily-driver container  

---

## Quick start

```bash
docker pull dev2choiz/nvim-in-docker:latest

docker run -it --rm \
    -v "$PWD":/app \
    --add-host=host.docker.internal:host-gateway \
    dev2choiz/nvim-in-docker:latest zsh
```
