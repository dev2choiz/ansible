# Ansible Setup

This project allows you to set up your development environment on Debian/Ubuntu.

---


## Full Installation


### Prepare Ansible Variables

Create the file `./vars/main.yml` by taking `./vars/main.yml.example` as a template.

Update it with your own data.

### Installation
Run the full setup from the root of the project:
```
./scripts/install.sh
```

**Installed tools:**
- ollama
- golang
- git
- docker
- font
- terminator
- nvim
- tmux
- fzf
- zsh
- chrome
- jetbrains_toolbox
- terraform
- devtoys
- postman
- insomnia
- dbeaver
- samba
- gotop
- nodejs
- gcloud
- vscode
- libreoffice

### Install only a few tools:
```
./scripts/install.sh --tags=golang,docker
```

## Install Neovim

You can install only Neovim:

```bash
./scripts/install-nvim.sh
# then run with
nvim .
```

The environment variable `NVIM_APPNAME` allows you to choose a custom configuration name.
Defaults to nvim if not set.

Or to customize the config name
```bash
NVIM_APPNAME=nvim-custom NVIM_CONFIG=lazyvim ./scripts/install-nvim.sh
# then run with
NVIM_APPNAME=nvim-custom nvim .
```

### One-Liner Installation from GitHub

You can run Neovim installation directly without cloning the repo:

```bash
sh -c "$(wget -O- https://raw.githubusercontent.com/dev2choiz/ansible/main/scripts/install-nvim-one-liner.sh)"
# then run with
nvim .
```

Or with a custom config name:
```bash
NVIM_APPNAME=nvim-custom NVIM_CONFIG=lazyvim sh -c "$(wget -O- https://raw.githubusercontent.com/dev2choiz/ansible/main/scripts/install-nvim-one-liner.sh)"
# then run with
NVIM_APPNAME=nvim-custom nvim .
```

possible values for NVIM_CONFIG: `lazyvim` | `astronvim`  
default value: `lazyvim`

### Run in docker

build the image
```bash
sh -c "$(wget -O- https://raw.githubusercontent.com/dev2choiz/ansible/main/scripts/install-nvim-in-docker.sh)"
```

then run it with your project directory as volume:
```bash
docker run -it --rm -v $(pwd):/app --add-host=host.docker.internal:host-gateway nvim-in-docker zsh

# when you are in the container, open nvim
nvim .
```
