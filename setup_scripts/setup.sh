#!/bin/bash

# Setup script to prepare new machine. I mostly pickup code from other's people dotfiles.
# Most of my thanks goes to Paul Irish

# Install xcode tools
./xcode.sh

# Install brew
echo "Installing Brew"

if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  then
    echo "Brew installed successful"
  else 
    echo "Error installing Brew"
fi

# Check the brew is in the path after installation before installing apps from Brewfile.
if ! type "brew" > /dev/null; then
  echo "Brew is not in path. Follow install instructions to add it. Then the setup script can
  continue."

  until ! type "brew" > /dev/null; do 
    sleep 5; 
  done 
fi

echo "Brew in path. Continue with installation from Brewfile"
echo ""
echo "Installing apps from Brewfile"

if brew bundle install --file=~/Dotfiles/backup/Brewfile
then
  echo "Installation from Brewfile successfull"
else 
  echo "Installation from Brewfile failed."
fi

# Install node and global node packages
# Install n node manager and latest LTS version of Node
curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n
sudo bash n lts

# Set npm to automatically install exact dependecies
npm config set save-exact true

# Install global npm modules
sudo ~/Dotfiles/setup_scripts/npm_install.sh

# Bootstrap dot files requested by ZSH
./paths.sh

# Install pip packages
./pip.sh

# Restore zsh/dotfiles
sudo pip3 install dotfiles
dotfiles -C ~/Dotfiles/.dotfilesrc --sync

# Configure iTerm to use custom settings.
# Set path to preferences
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.iterm_settings"
# Enable custom preferences
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

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
