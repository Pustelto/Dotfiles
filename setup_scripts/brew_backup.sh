#!/bin/bash

DOTFILES_BREW_BACKUP=~/Dotfiles/backup/brew

# Backup brew apps
echo \# brew:start > $DOTFILES_BREW_BACKUP

if brew list -1 | sed '/^\s*$/d' >> $DOTFILES_BREW_BACKUP
  then
    echo "Brew apps backup sucessfully."
  else
    echo "Error when creating list of brew apps."
fi

echo \# brew:end >> $DOTFILES_BREW_BACKUP

# Backup brew cask apps
echo "" >> $DOTFILES_BREW_BACKUP

echo \# brew-cask:start >> $DOTFILES_BREW_BACKUP

if brew cask list -1 | sed '/^\s*$/d' >> $DOTFILES_BREW_BACKUP
  then
    echo "Brew Cask apps backup sucessfully."
  else
    echo "Error when creating list of brew Cask apps."
fi

echo \# brew-cask:end >> $DOTFILES_BREW_BACKUP
