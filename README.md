# Arch Basic Install CLI-Script

In this repository you will find packages-scripts for the base install of Arch Linux and the Gnome and Hyprland desktop environments. Modify the packages to your liking and make sure to understand what you are installing packages. Customisations should be done manually or part of a separate project/script that has not been created yet. Remember that the first part of the Arch Linux install is manual, that is you will have to partition, format and mount the disk yourself. Install the base packages and make sure to include git so that you can clone the repository in chroot.

A small summary:

1. If needed, load your keymap
2. Refresh the servers with pacman -Syy
3. Partition the disk
4. Format the partitions
5. Mount the partitions
6. Install the base packages into /mnt
    (pacstrap -K /mnt base linux linux-firmware networkmanager git vim man-db amd-ucode)
7. Generate the fstab file with genfstab -U /mnt >> /mnt/etc/FSTAB
8. Chroot in with arch-chroot /mnt
9. Download the git repository with git clone https://github.com/marviu/arch-basic.git
10. Execute ./base.sh

## Special thanks to
Ermanno Ferrari, for the basis and inspiration to maintain a Setup script for myself!

It's nice to have it organised and documented. I placed a particular focus on making the script re-executable without much issues, and also used this opportunity to practice writing some bash scripts.

