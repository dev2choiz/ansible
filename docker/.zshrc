export ZSH="$HOME/.oh-my-zsh"

for fsh in "$HOME/.zshrc.d/early.d/"*.{sh,zsh}(N); do
  . "$fsh"
done
unset -v fsh

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  golang

  tmux
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

command -v fzf >/dev/null && source <(fzf --zsh)

export EDITOR='vim'
export DOTFILES_THEME=gruvbox

alias eza="eza -a -l -g --total-size --icons=always --hyperlink"
alias bat="batcat"
alias ws="cd /app"

for fsh in "$HOME/.zshrc.d/"*.{sh,zsh}(N); do
  . "$fsh"
done
unset -v fsh

