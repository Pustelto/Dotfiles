#!/bin/bash

# This script will read all globaly installed npm packages and save them to file
# which can be versioned and used as a source to install all necessary npm
# scripts on new machine

# Command below includes linked packages as well, we want to ignore these
# we can get linked pkgs via `npm ls --depth=0 -g` which will give us
# this output for such a pkg:
#
# react-tags-autocomplete@0.1.0 -> /Users/pustelto/Work/m360/src/react-tags-autocomplete
#
# This `npm ls --depth=0 -g | awk '/->/ {print $2;}'` will return only link pkgs

DOTFILES_LINK_NPM=$( npm ls --depth=0 -g | awk '/->/ {print $2;}' )

if [ -s $DOTFILES_LINK_NPM ]
  then
    if npm ls --depth=0 -g --parseable --long | cut -f2 -d: |awk -F '@' '{for (i=1; i <= NF - 1; i++) printf $i""; print""}' | sed '/^\s*$/d' > ~/Dotfiles/backup/npm
      then
        echo "Global NPM modules list saved."
      else
        echo "Error when creating list of global NPM modules."
    fi
  else
    # This command gets all global npm pkgs, select only their name and version,
    # remove linked pkgs and empty lines and write result to npm_backup file
    # if npm ls --depth=0 -g --parseable --long | cut -f2 -d: | awk '$1 !~ /'$DOTFILES_LINK_NPM'/' | sed '/^\s*$/d' > ~/Dotfiles/backup/npm
    awk '{for (i=3; i <= NF; i++) printf $i""FS; print""}'
    if npm ls --depth=0 -g --parseable --long | cut -f2 -d: | awk '$1 !~ /'$DOTFILES_LINK_NPM'/' | awk -F '@' '{for (i=1; i <= NF - 1; i++) printf $i""; print""}' | sed '/^\s*$/d' > ~/Dotfiles/backup/npm
      then
        echo "Global NPM modules list saved."
      else
        echo "Error when creating list of global NPM modules."
    fi
fi
