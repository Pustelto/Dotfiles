
#!/bin/bash

# This script will read all globaly installed cargo packages and save them to file
# which can be versioned and used as a source to install all necessary cargo 
# packages on new machine.

CARGO_PATH=$HOME/.cargo/bin/

if [ -d "$CARGO_PATH" ];
  then
    if ls $HOME/.cargo/bin/ > ~/Dotfiles/backup/cargo;
      then
        echo "Global cargo packages list saved."
      else
        echo "Error when creating list of global cargo packages."
    fi
  else 
    echo "no cargo packages found"
fi
