#!/bin/bash

# Get the directory of the currently executing script
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define bash helper folder 'h'
h="bash $script_dir/helper"

$h/uncomment_locale "en_CA.UTF-8 UTF-8"
$h/uncomment_locale "de_DE.UTF-8 UTF-8"
locale-gen
$h/findOrAdd_line /etc/locale.conf "LANG=en_CA.UTF-8"
$h/findOrAdd_line /etc/vconsole.conf "KEYMAP=de-latin1"
echo "aoba" > /etc/hostname
$h/check_root_pw

# pacman -S grub efibootmgr networkmanager...

# pacman -S --noconfirm xf86-video-amdgpu

#grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
#grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
#systemctl enable bluetooth
#systemctl enable cups.service
#systemctl enable sshd
#systemctl enable avahi-daemon
#systemctl enable reflector.timer
#systemctl enable fstrim.timer
#systemctl enable firewalld
#systemctl enable acpid

#useradd -m drace
#echo drace:password | chpasswd

#echo "drace ALL=(ALL) ALL" >> /etc/sudoers.d/drace

echo "Done!"

