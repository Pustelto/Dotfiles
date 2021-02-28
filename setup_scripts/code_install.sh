#!/bin/bash

DOTFILES_CODE_SETTINGS=~/Library/Application\ Support/Code/User

# Link VS Code settings
if ln ~/Dotfiles/code/settings/* "$DOTFILES_CODE_SETTINGS"
  then
    echo "VS Code settings linked successfully"
  else
    echo "VS Code linking error"
fi

# # Link VS Code snippets
if ln ~/Dotfiles/code/snippets/* "$DOTFILES_CODE_SETTINGS"/snippets
  then
    echo "VS Code snippets linked successfully"
  else
    echo "VS Code snippets linking error"
fi

# Install extentions
if cat ~/Dotfiles/backup/code_extensions | xargs -L 1 code --install-extension
  then
    echo "VS Code extensions installed successfully, please reload your VS Code"
  else
    echo "VS Code extensions installation error"
fi
