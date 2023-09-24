#!/bin/bash

# Get the directory of the currently executing script
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define bash helper folder 'h'
h="bash $script_dir/helper"

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
$h/uncomment_line /etc/locale.gen "en_CA.UTF-8 UTF-8"
$h/uncomment_line /etc/locale.gen "de_DE.UTF-8 UTF-8"
locale-gen
$h/findOrAdd_line /etc/locale.conf "LANG=en_CA.UTF-8"
$h/findOrAdd_line /etc/vconsole.conf "KEYMAP=de-latin1"
echo "aoba" > /etc/hostname
$h/check_user_pw root

pacman -S --needed grub efibootmgr os-prober networkmanager

# pacman -S --noconfirm xf86-video-amdgpu

# Comment this line and remove os-prober package for non-dualboot
$h/uncomment_line /etc/default/grub "GRUB_DISABLE_OS_PROBER=false"

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
#systemctl enable bluetooth
#systemctl enable cups.service
#systemctl enable sshd
#systemctl enable avahi-daemon
#systemctl enable reflector.timer
#systemctl enable fstrim.timer
#systemctl enable firewalld
#systemctl enable acpid

useradd drace
$h/check_user_pw drace

#echo "drace ALL=(ALL) ALL" >> /etc/sudoers.d/drace

echo "Done!"

