#!/bin/bash 
#
# Initial file with hyprland specific actions
# To be extended with more functionality, reusing code, and making it able to be executed as a standalone setup script.
if [ "$UID" -eq 0 ]; then
    echo "You are currently logged in as root. Please run this script as a regular user."
    exit 1
fi

if [ -z "$HOME" ]; then
    echo "\$HOME is not set."
    exit 1
fi


# Clone config files into bare repository, alias listed in .bashrc called hyprgit for usage
gitDirectory="$HOME/.config/hyprgit.git"
if [ ! -d $gitDirectory ]; then
    git clone --bare git@github.com:marviu/hyprgit.git $gitDirectory
    git --git-dir="$gitDirectory" config status.showUntrackedFiles no
    echo "Please run 'hyprgit status' to check, and then to discard all changes:"
    echo "hyprgit reset && hyprgit checkout -- ~/.config/."
else
    echo "Config repository already exists."
fi

# List of specific applications
hyprland="hyprland wofi waybar fnott"
sudo pacman -Syu --needed $hyprland

