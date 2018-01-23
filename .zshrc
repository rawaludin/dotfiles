# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
DEFAULT_USER="rahmatawaludin"

# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# screenshot buku Menyelami Framework Laravel theme
# ZSH_THEME="agnoster"

# taylor otwell theme
# ZSH_THEME="steeef"

# sindresorhus theme (screnshot buku Seminggu Belajar Laravel dan API) (pakai iterm white)
# https://github.com/sindresorhus/pure
# intentionally disable zsh themes to use pure themes through npm package
# ZSH_THEME="pure"

LANG=en_US.utf8
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git history history-substring-search themes alias-tips vi-mode golang docker-compose zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/Users/rahmatawaludin/.composer/vendor/bin:/usr/X11/bin:/Users/rahmatawaludin/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Applications/Postgres.app/Contents/Versions/latest/bin"

# Go lang config
export GOPATH=$HOME/gocode
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Android SDK
export ANDROID_HOME=/Users/rahmatawaludin/Code/android-sdk-macosx
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# Ruby
# export RBENV_ROOT=/usr/local/var/rbenv
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# rbenv rehash

# How do I?
alias h="howdoi"

# quicklook from terminal
alias qlf='qlmanage -p "$@" > /dev/null'

# Set the default editor
export EDITOR="nvim"
alias s="subl"
alias e="nvim"

# hub
alias git="hub"

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# ----------------------------
# My Functions
# ----------------------------

# `o` with no arguments opens current directory, otherwise opens the given
# location
function o() {
    if [ $# -eq 0 ]; then
        open .
    else
        open "$@"
    fi
}

# timer
function st() {
  BEGIN=$(date +%s)
  if [ -z "$1" ]; then
    echo Starting Stopwatch...
  else
    echo $@...
  fi

  while true; do
     NOW=$(date +%s)
     let DIFF=$(($NOW - $BEGIN))
     let MINS=$(($DIFF / 60 % 60))
     let SECS=$(($DIFF % 60))
     let HOURS=$(($DIFF / 3600 % 24))
     let DAYS=$(($DIFF / 86400))
     # \r  is a "carriage return" - returns cursor to start of line
     printf "\e[36m\r%3d Days, %02d:%02d:%02d" $DAYS $HOURS $MINS $SECS
     sleep 0.25
  done
}

# write new note
function n() {
  nvim ~/Dropbox/Notes/"$*".md
}

# view all note
nls() {
  ls -c ~/Dropbox/Notes/ | grep "$*"
}

# open man with vim
vman() {
  vim -c "SuperMan $*"

  if [ "$?" != "0" ]; then
    echo "No manual entry for $*"
  fi
}

# enter the syntax on the command line and either copy from the clipboard (light js) or pass a filename too (light js func.js).
function light() {
  if [ -z "$2" ]
    then src="pbpaste"
  else
    src="cat $2"
  fi
  $src | highlight -O rtf --syntax $1 --font Inconsolata --style solarized-light --font-size 24 | pbcopy
}

# open dash query using dash {term}
function dash() {
    if [ $# -eq 0 ]; then
        open dash://
    else
        open dash://"$@"
    fi
}

# prepare video thumbnail for malescast post
function prepareThumbnail() {
  PROJECT_PATH="/Users/rahmatawaludin/Code/malescast-hexo"
  POSTER_PATH="$PROJECT_PATH/source/img/poster/"
  THUMBNAIL_PATH="$PROJECT_PATH/source/img/thumbnail/"
  echo $POSTER_PATH
  UUID=`date | md5 -r | cut -c 1-8`
  video=$1
  name=$2
  filename=`echo ${name}-${UUID}.jpg`

  # generate poster
  ffmpeg -ss 1 -i $video -vf scale=848:-1 -qscale:v 2 -vframes 1 `echo ${POSTER_PATH}${filename}`

  # generate thumbnail
  ffmpeg -ss 1 -i $video -vf scale=530:-1 -qscale:v 2 -vframes 1 `echo ${THUMBNAIL_PATH}${filename}`

  echo "Optimizing image.."
  /Applications/ImageOptim.app/Contents/MacOS/ImageOptim `echo ${POSTER_PATH}${filename}`
  /Applications/ImageOptim.app/Contents/MacOS/ImageOptim `echo ${THUMBNAIL_PATH}${filename}`

  echo "Poster generated to `echo ${POSTER_PATH}${filename}`"
  echo "Thumbnail generated to `echo ${THUMBNAIL_PATH}${filename}`"
}

# create dir and cd
function mkcd {
  if [ ! -n "$1" ]; then
    echo "Enter a directory name"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}

# create go project
function gon {
 cd $GOPATH/src/github.com/rahmatawaludin

 if [ ! -n "$1" ]; then
   echo "Enter a directory name"
 elif [ -d $1 ]; then
   echo "\`$1' already exists"
 else
   mkdir $1 && cd $1
   nvim main.go
 fi
}

# ----------------------------
# My ALias
# ----------------------------

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm update npm -g; npm update -g; sudo gem update'

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# todotxt
alias td="todo.sh"
# Laravel
export LARAVEL_ENV="local"

# laravel artisan
alias art="php artisan"

# Larave IDE helper
function setup-helper() {
  composer require barryvdh/laravel-ide-helper -vvv
  lf=$'\n'
  sed -i " " "138s/.*/        'Barryvdh\\\LaravelIdeHelper\\\IdeHelperServiceProvider',\\$lf/" config/app.php
  php artisan clear-compiled
  php artisan ide-helper:generate -M
  php artisan optimize
  echo "_ide_helper.php" >> .gitignore
}

function refresh-helper() {
  php artisan clear-compiled
  php artisan ide-helper:generate -M
  php artisan optimize
}

# homestead stuff
alias homestead-mysql="mysql -uhomestead -psecret --host 127.0.0.1 --port 33060 homestead"

# phpunit
alias tc="./vendor/bin/phpunit"
alias t="./vendor/bin/phpunit --no-coverage"
alias ts="./vendor/bin/phpunit --no-coverage --stop-on-error --stop-on-fail"
# execute phpunit in docker (kw-crm project)
alias tt="doo ./vendor/bin/phpunit --no-coverage"

# Ruby on Rails
alias r="rails"

# Mamp alias
# alias mysql="/Applications/MAMP/Library/bin/mysql"

# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

# Custom plugin
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Configure fasd
if [ $commands[fasd] ]; then # check if fasd is installed
  fasd_cache="${ZSH_CACHE_DIR}/fasd-init-cache"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install \
      zsh-wcomp zsh-wcomp-install>| "$fasd_cache"
  fi
  source "$fasd_cache"
  unset fasd_cache
  alias v='fasd -e nvim'
fi

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

# Change cursor when in normal or insert mode in zsh vi mode
# TODO: make history-substring-search plugin stay active while have this
# function print_dcs
# {
#   print -n -- "\EP$1;\E$2\E\\"
# }
#
# function set_cursor_shape
# {
#   if [ -n "$TMUX" ]; then
#     # tmux will only forward escape sequences to the terminal if surrounded by
#     # a DCS sequence
#     print_dcs tmux "\E]50;CursorShape=$1\C-G"
#   else
#     print -n -- "\E]50;CursorShape=$1\C-G"
#   fi
# }
#
# function zle-keymap-select zle-line-init
# {
#   case $KEYMAP in
#     vicmd)
#       set_cursor_shape 0 # block cursor
#       ;;
#     viins|main)
#       set_cursor_shape 1 # line cursor
#       ;;
#   esac
#   zle reset-prompt
#   zle -R
# }
#
# function zle-line-finish
# {
#   set_cursor_shape 0 # block cursor
# }
#
# zle -N zle-line-init
# zle -N zle-line-finish
# zle -N zle-keymap-select

# base16 color
# BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Fix autosuggestion color bug on tmux 
# see https://github.com/zsh-users/zsh-autosuggestions/issues/229#issuecomment-300675586
export TERM=xterm-256color

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
