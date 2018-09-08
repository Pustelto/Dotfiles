# GENERAL SETTINGS
# -------------------------------------

# Set language to UTF-8 - it should fix autocomplete indent issue
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# allow custom path setup per device without commiting possibly sensitive data
# (path_exports is not versioned)
source ~/.path_exports
export PATH=$PATH$CUSTOM_PATH

# ENV AND PLUGINS
# -------------------------------------

# Load autocompletitions
autoload -Uz compaudit compinit

typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# Load comp list module
zmodload -i zsh/complist

# Configure history
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
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

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# Enable ls colors
autoload colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Load plugins
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
source ~/.zsh_plugins.sh

# Binding for zsh-users/zsh-history-substring-search plugin
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Settings for zsh-notify plugin
zstyle ':notify:*' notifier /usr/local/bin/terminal-notifier
zstyle ':notify:*' error-title "Failed with #fail"
zstyle ':notify:*' success-title "Ended with #success"
# zstyle ':notify:*' error-icon "https://media3.giphy.com/media/10ECejNtM1GyRy/200_s.gif"
# zstyle ':notify:*' success-icon "https://s-media-cache-ak0.pinimg.com/564x/b5/5a/18/2.jpg"

export TERM=xterm-256color

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height=100% --border'

# Bat config
export BAT_THEME="Monokai Extended"
export BAT_PAGER=less

# Set default pager and force it clear screen after quit
export PAGER=less
export LESS="-RF"

# USER CONFIGURATION
# -------------------------------------

source ~/Dotfiles/shell/git.zsh #shamelessly taken from oh-my-zsh
source ~/Dotfiles/shell/.aliases
source ~/Dotfiles/shell/.functions
