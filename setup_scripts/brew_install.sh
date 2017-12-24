#!/bin/bash

# This script will install apps via brew which are defined in
# Dotfiles/backup/brew file

DOTFILES_BREW_BACKUP=~/Dotfiles/backup/brew

# Get brew apps from backup file
# see [this stackoverflow](https://stackoverflow.com/questions/17988756/how-to-select-lines-between-two-marker-patterns-which-may-occur-multiple-times-w) for details.
BREW_APPS=$( awk '/brew:start/{flag=1;next}/brew:end/{flag=0}flag' $DOTFILES_BREW_BACKUP  )

if [ -n "$BREW_APPS" ]
  then
    if brew install $BREW_APPS;
      then
        echo "Brew apps installed successfully."
      else
        echo "There was an error when installing brew apps."
    fi
  else
    echo 'Brew: no apps to install'
fi

# Brew Cask apps
BREW_CASK_APPS=$( awk '/brew-cask:start/{flag=1;next}/brew-cask:end/{flag=0}flag' $DOTFILES_BREW_BACKUP  )

if [ -n "$BREW_CASK_APPS" ]
  then
    if brew install $BREW_CASK_APPS;
      then
        echo "Brew Cask apps installed successfully."
      else
        echo "There was an error when installing brew cask apps."
    fi
  else
    echo 'Brew Cask: no apps to install'
fi
