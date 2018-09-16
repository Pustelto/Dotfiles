#!/bin/bash

DOTFILES_CODE_BACKUP=~/Dotfiles/backup/code_extensions

# Backup extensions
if code --list-extensions > $DOTFILES_CODE_BACKUP
  then
    echo "VS Code extensions backup sucessfully."
  else
    echo "Error when creating list of VS Code extensions."
fi
