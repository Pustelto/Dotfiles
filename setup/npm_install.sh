#!/bin/bash

# This script will install globaly npm packages which are defined in
# Dotfiles/backup/npm file

if npm install `< ~/Dotfiles/backup/npm` -g
  then
    echo "NPM packages installed successfully."
  else
    echo "There was an error when installing NPM packages."
fi
