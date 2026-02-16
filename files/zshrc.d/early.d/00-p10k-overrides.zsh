# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
 source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Customize the prompt by running `p10k configure` or editing `~/.p10k.zsh`
[[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh

theme="${DOTFILES_THEME:-gruvbox}"

if [[ "$theme" == "gruvbox" ]]; then
  POWERLEVEL9K_DIR_FOREGROUND='#ebdbb2'
  POWERLEVEL9K_DIR_BACKGROUND='#282828'
  POWERLEVEL9K_DIR_ANCHOR_FOREGROUND='#fabd2f'
  POWERLEVEL9K_DIR_ANCHOR_BACKGROUND='#282828'
  POWERLEVEL9K_DIR_SHORTENED_FOREGROUND='#ebdbb2'
  POWERLEVEL9K_DIR_SHORTENED_BACKGROUND='#282828'

  POWERLEVEL9K_BACKGROUND='#282828'
  POWERLEVEL9K_FOREGROUND='#ebdbb2'

  POWERLEVEL9K_TIME_FOREGROUND='#83a598'
  POWERLEVEL9K_USER_FOREGROUND='#fabd2f'
  POWERLEVEL9K_HOST_FOREGROUND='#b8bb26'
  POWERLEVEL9K_STATUS_FOREGROUND='#fb4934'

  # vcs
  POWERLEVEL9K_VCS_FOREGROUND='#282828'
  POWERLEVEL9K_VCS_CLEAN_BACKGROUND='#b8bb26'
  POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='#fe8019'
  POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='#8ec07c'
  POWERLEVEL9K_VCS_CONFLICTED_BACKGROUND='#fb4934'
  POWERLEVEL9K_VCS_LOADING_BACKGROUND='#83a598'
fi
