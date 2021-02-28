#!/bin/bash

DOTFILES_BREW_BACKUP=~/Dotfiles/backup/Brewfile

if brew bundle dump -f --file=$DOTFILES_BREW_BACKUP
  then
    echo "Brew apps backup sucessfully."
  else
    echo "Error when creating list of brew apps."
fi
