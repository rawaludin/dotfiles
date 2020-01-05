

#
# User configuration sourced by interactive shells
#
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Change default zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh

# Load alias, function, etc
source "${ZDOTDIR:-$HOME}/.alias.sh"
source "${ZDOTDIR:-$HOME}/.function.sh"

# history-substring-search ^p ^n or up down (in vim mode) to search
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# z quick jump
. ~/dotfiles/bin/z.sh

# Configure FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
# Use fd for fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --no-ignore-vcs'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# preview
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
source $HOME/dotfiles/fzf-helpers/keybindings.plugin.zsh

# Modify PATH
export PATH=$HOME/dotfiles/bin:$HOME/.composer/vendor/bin:$(brew --prefix)/bin:$HOME/go/bin:$PATH
# Set the default editor
export EDITOR="nvim"
# ^x^e to edit current command in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Install https://github.com/kaelzhang/shell-safe-rm manually
#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
