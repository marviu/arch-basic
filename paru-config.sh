#!/bin/bash

# Get the current username
current_user=$(whoami)

# Check if the current user is "drace"
if [ "$current_user" != "drace" ]; then
    echo "This script must be run by the user 'drace'."
    exit 1
else
    echo "User is $current_user."
fi

if command -v paru &> /dev/null; then
    echo "paru is already installed."
    exit 0
fi

# Code for installing
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg --syncdeps --rmdeps --install # --rmdeps removes the make dependencies later

# Remove folder after
cd ..
sudo rm -rf paru

