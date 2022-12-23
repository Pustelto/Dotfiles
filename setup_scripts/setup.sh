# Setup script to prepare new machine. I mostly pickup code from other's people dotfiles.
# Most of my thanks goes to Paul Irish

# Install xcode tools
./xcode.sh

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew bundle install --file=~/Dotfiles/backup/Brewfile

# Install node and global node packages
# Install n node manager and latest LTS version of Node
curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n
sudo bash n lts

# Set npm to automatically install exact dependecies
npm config set save-exact true

# Install global npm modules
~/Dotfiles/setup_scripts/npm_install.sh

# Bootstrap dot files requested by ZSH
./paths.sh

# Install pip packages
./pip.sh

# Restore zsh/dotfiles
sudo pip3 install dotfiles
dotfiles ---sync

# Download Tmux package manager so we can use Tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Plugins still have to be loaded manually from Tmux using Prefix + I

# Set mac settings (hidden folders, tabing in dialogs, etc.)
./macos

# TODO
# Restore vs code settings/plugins
# Need to check if snippets folder exist, on fresh install it will not so we need to create it
~/Dotfiles/setup_scripts/code_install.sh

# TODO
# Restore iterm settings
# Restore backup data not stored in Git
# Network settings
# Other data
