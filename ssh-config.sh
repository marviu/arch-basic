#!/bin/bash

ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo "Then select and copy the contents of the id_ed25519.pub file displayed in the terminal to your clipboard and add it to your git profile"
cat ~/.ssh/id_ed25519.pub

sleep 5s
# I.e. for main configuration file
alias config="/usr/bin/git --git-dir=$HOME/.config/linuxconfig.git/ --work-tree=$HOME"
echo "Don't forget to disable tracking other files in your bare git repos:"
echo "config config --local status.showUntrackedFiles no"

