#!/bin/bash

# Check if .path_exports file exist in $HOME and if not copy a bootstrap file
if [ -e ~/.path_exports ]
  then
    echo ".path_exports file already exist"

  else
    # Relative path is from folder when the script was run, not where the script
    # is actually located, so we first get the path to file (may not always work)
    DIR=$( dirname "${BASH_SOURCE[0]}" )

    # Then we try to copy the file
    if cp $DIR/.path_exports ~/.path_exports
      then
        echo "Example .path_exports file was copied to home dir"
      else
        echo "Error when copying .path_exports"
    fi
fi

# Create .variables file if necessary
if [ -e ~/.variables ]
  then
    echo ".variables file already exist"

  else
    # Then we try to copy the file
    if touch $HOME/.variables
      then
        echo "Example .path_exports file was copied to home dir"
      else
        echo "Error when copying .path_exports"
    fi
fi