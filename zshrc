# GENERAL SETTINGS
# -------------------------------------

# Set language to UTF-8 - it should fix autocomplete indent issue
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# ENV AND PLUGINS
# -------------------------------------

# Init antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

# Path to theme
# Has to be set before antidote otherwise the THEME_PATH will be incorrect
export THEME_PATH=$(antidote home)/https-COLON--SLASH--SLASH-github.com-SLASH-Pustelto-SLASH-shell_theme

# Load autocompletitions
# First load Brew autocompletions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Need to init completitions commands as they may be used by some plugins
autoload -Uz compaudit compinit

typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# Load comp list module
zmodload -i zsh/complist

# Load antidote plugins
antidote load

# Configure history
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
# ignore commands begining with space and duplicates - ignorespace | ignoredups
HISTCONTROL=ignoreboth
SAVEHIST=$HISTSIZE

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell

# Working with directories
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# Other improvements
setopt correct_all # autocorrect commands
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

# select completions with arrow keys
zstyle ':completion:*' menu select
# group results by category
zstyle ':completion:*' group-name ''
# enable approximate matches for completion
zstyle ':completion:::::' completer _expand _complete _ignored _approximate

# Enable ls colors
autoload colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Binding for zsh-users/zsh-history-substring-search plugin
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Settings for zsh-notify plugin
zstyle ':notify:*' notifier $(brew --prefix)/bin/terminal-notifier
zstyle ':notify:*' error-title "Failed with #fail"
zstyle ':notify:*' success-title "Ended with #success"
# zstyle ':notify:*' error-icon "https://media3.giphy.com/media/10ECejNtM1GyRy/200_s.gif"
# zstyle ':notify:*' success-icon "https://s-media-cache-ak0.pinimg.com/564x/b5/5a/18/2.jpg"

export TERM=xterm-256color

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Basic settings
export FZF_DEFAULT_OPTS='--height=100% --border'
# Color scheme
export FZF_DEFAULT_OPTS='--color=bg+:#293739,bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92672 '$FZF_DEFAULT_OPTS
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow -E node_modules -E .git'

# Command for auto completitions for other commands (eg. vim **)
_fzf_compgen_path() {
  fd --type f --hidden --follow --no-ignore --exclude ".git" --exclude "node_modules" . "$1"
}

# ripgrep config file
RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# Bat config
# export BAT_THEME="Monokai Extended"
# export BAT_PAGER=less

# Set default pager and force it clear screen after quit
# export PAGER=less
# export LESS="-RF"

# USER CONFIGURATION
# -------------------------------------

export GIT_BRANCH_CLEANER_BLACKLIST=master
export NODE_OPTIONS=--max-old-space-size=8192

source ~/Dotfiles/shell/git.zsh #shamelessly taken from oh-my-zsh
source ~/Dotfiles/shell/.aliases
source ~/Dotfiles/shell/.functions

if [ -f ~/.variables ]; then
  source ~/.variables
fi

# RUST
# -------------------------------------
export PATH=/Users/tomas.pustelnik/.cargo/bin:$PATH

# ATACCAMA CONFIGURATION
# -------------------------------------
# source ~/Dotfiles/ataccama
#
# export PATH=$HOME/.docker/bin:$PATH
#
# # Created by `pipx` on 2024-09-10 14:13:01
# export PATH="$PATH:/Users/Tomas.Pustelnik/.local/bin"
#
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"

# allow custom path setup per device without commiting possibly sensitive data
# (path_exports is not versioned)
if [ -f ~/.path_exports ]; then
  source ~/.path_exports
fi

export PATH=$CUSTOM_PATH$PATH
