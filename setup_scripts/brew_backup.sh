#!/bin/bash

DOTFILES_BREW_BACKUP=~/Dotfiles/backup/

if brew bundle dump -f
  then
    echo "Brew apps backup sucessfully."
  else
    echo "Error when creating list of brew apps."
fi
