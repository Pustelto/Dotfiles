# Set language to UTF-8 - it should fix autocomplete indent issue
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

source ~/.path_exports
export PATH=$PATH$CUSTOM_PATH

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="pustelto"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git extract sublime)

source $ZSH/oh-my-zsh.sh

# User configuration

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias sourcezsh="source ~/.zshrc"
alias xt="extract"
alias nodeclr="rm -rf ./node_modules && yarn"
alias tmux="tmux -2"
alias ll="ls -lhFG"
alias la="ls -lahFG"
alias gpfl="git push --force-with-lease"
alias gstau="git stash -u"
alias gstap="git stash apply"
alias gcn!!='git commit -v --no-edit --amend --no-verify'
alias myghi="ghi list --mine"
