# install xcode tools

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew bundle install --file=~/Dotfiles/backup/Brewfile

# install node and global node packages
# We need to isntall node from the web so we have to do it manually
~/Dotfiles/setup_scripts/npm_install.sh

# restore zsh/dotfiles
sudo pip3 install dotfiles

dotfiles ---sync

# restore vs code settings/plugins
# Need to check if snippets folder exist, on fresh install it will not so we need to create it
~/Dotfiles/setup_scripts/code_install.sh

# set mac settings (hidden folders tabing in dialogs etc.)

