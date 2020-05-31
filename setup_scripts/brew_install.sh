#!/bin/bash

if brew bundle install
  then
    echo "Brew apps installed sucessfully."
  else
    echo "Error when installing brew apps."
fi
