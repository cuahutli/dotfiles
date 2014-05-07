# Path to your oh-my-zsh configuration.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="doubleend"
ZSH_THEME="agnoster"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to enable command autocorrection
ENABLE_CORRECTION="true"

# Uncomment following line if you want to disable command arguments autocorrection
DISABLE_CORRECTION_ARGS="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="dd.mm.yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-extras batcharge z dict npm ragekill zsh_reload gitignore omz-bootstrap sudo)

source "$ZSH/oh-my-zsh.sh"

# Idle title
ZSH_THEME_TERM_TITLE_IDLE="%m: %~"

# enable color support
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# ls completion dir_colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# complete . and .. directories
zstyle ':completion:*' special-dirs true

# paginated completion
zstyle ':completion:*' list-prompt   ''
zstyle ':completion:*' select-prompt ''

# Example aliases
alias ohmyzsh="subl ~/.oh-my-zsh"
alias zshrc="subl ~/.zshrc"


## User configuration

# Package suggestions on command not found
[[ -f /etc/zsh_command_not_found ]] && . /etc/zsh_command_not_found

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

## Sourcing extern files

# aliases
[[ -f ~/.aliases ]] && . ~/.aliases

# functions
[[ -f ~/.functions ]] && . ~/.functions

## PATH settings

# DISCUSSION:
# 1) path settings should all go to .profile?
# 2) how to prevent duplicates -> `typeset -U path` to remove duplicates
# 3) which syntax to use to be portable (related [2], only in zsh?)

# source path modifications
# [[ -f ~/.paths ]] && . ~/.paths

# bin folders
if [ -d ~/bin ]; then
  path+=~/bin
  for dir in ~/bin/*(/); do path+="$dir" done > /dev/null 2>&1
  unset dir
fi

# local folder
if [ -d ~/local ]; then
    [ -d ~/local/bin ] && path+=~/local/bin
fi

# opt folder
if [ -d ~/opt ]; then
    for dir in ~/opt/*(/); do
        [ -d "$dir/bin" ] && path+="$dir/bin"
    done
    unset dir
fi

# android
if [ -d ~/opt/android ]; then
  path+=(~/opt/android/{platform-,}tools)
fi

# ruby gems
if which ruby &>/dev/null && which gem &>/dev/null; then
    path+="$(ruby -rubygems -e 'puts Gem.user_dir')/bin"
fi

# current directory at the end
path+=.

# force unique values in $PATH
typeset -U path

## extended globbing (adds ^ and other symbols as wildcards)
setopt extended_glob
# correct behaviour when specifying commit parent (commit^)
alias git='noglob git'
# prevent adding files as key strokes when using bindkey
alias bindkey='noglob bindkey'

## TETRIS!
autoload -U tetris
zle -N tetris
bindkey ^T tetris