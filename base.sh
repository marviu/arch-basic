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

# Pacman Setup + install reflector
cp $script_dir/pacman.conf /etc/
pacman -Syy
$h/initialise_reflector "France,Germany,Belgium,Denmark"

pacman -S --needed grub efibootmgr os-prober networkmanager base-devel xdg-user-dirs avahi nss-mdns cups docker

# pacman -S --noconfirm xf86-video-amdgpu

# GRUB - Comment first line and remove os-prober for non-dualboot setup
$h/uncomment_line /etc/default/grub "GRUB_DISABLE_OS_PROBER=false"
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Set up package configurations (xdg-user-dirs, vim spacing, nss-mdns for printing, ...)
sed -i 's/=.*/\L&/' /etc/xdg/user-dirs.defaults
$h/findOrAdd_line /etc/vimrc "set tabstop=4 shiftwidth=4 expandtab" '" Make tabbing work as expected, shiftwidth is for << and >>'
$h/enable_local_hostname_resolv_avahi


systemctl enable NetworkManager
systemctl enable reflector.timer
systemctl enable cups.service
systemctl enable avahi-daemon
systemctl enable docker.socket
#systemctl enable bluetooth
#systemctl enable sshd
#systemctl enable fstrim.timer
#systemctl enable firewalld
#systemctl enable acpid

$h/uncomment_line /etc/sudoers "%wheel ALL=(ALL:ALL) ALL"
useradd -m drace
usermod -a -G wheel drace
$h/check_user_pw drace

echo "Done!"

