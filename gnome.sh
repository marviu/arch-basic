#!/bin/bash

# Get the directory of the currently executing script
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# After systemd-firstboot: We may enable usage of NTP for time-sync (defaults to i.e. systemd-timesyncd)
sudo timedatectl set-ntp true
sudo hwclock --systohc

# Hardware acceleration packages (AMD) (

# Lists of specific applications
gnome="gnome"

# Lists of general applications/drivers
cli_apps="lf tldr timew task"
pipewire_explicit="pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack lib32-pipewire lib32-pipewire-jack"
multimedia_apps="pavucontrol vlc filezilla"
communication_apps="discord telegram-desktop teamspeak3"
fonts="noto-fonts-cjk"

# Requirements taken from LeagueOfLinux, it's AMD-typed(!!)
gaming_apps="lutris steam"
amd_drivers="lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader"
drivers="wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader"

all_apps="$cli_apps $pipewire_explicit $multimedia_apps $communication_apps $gaming_apps $fonts $amd_drivers $drivers $gnome"

# Please investigate that on a new install, these are installed properly, and if the -R is needed
sudo pacman -R pulseaudio pulseaudio-alsa pulseaudio-bluetooth
sudo pacman -Syu --needed $all_apps
#sudo firewall-cmd --add-port=1025-65535/tcp --permanent
#sudo firewall-cmd --add-port=1025-65535/udp --permanent
#sudo firewall-cmd --reload
## sudo virsh net-autostart default


#sudo pacman -S gnome-shell gdm gnome-control-center gnome-tweaks
#sudo pacman -S --noconfirm xorg gdm gnome gnome-extra firefox gnome-tweaks simplescreenrecorder arc-gtk-theme arc-icon-theme obs-studio vlc dina-font tamsyn-font bdf-unifont ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid gnu-free-fonts ttf-ibm-plex ttf-liberation ttf-linux-libertine noto-fonts ttf-roboto tex-gyre-fonts ttf-ubuntu-font-family ttf-anonymous-pro ttf-cascadia-code ttf-fantasque-sans-mono ttf-fira-mono ttf-hack ttf-fira-code ttf-inconsolata ttf-jetbrains-mono ttf-monofur adobe-source-code-pro-fonts cantarell-fonts inter-font ttf-opensans gentium-plus-font ttf-junicode adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts noto-fonts-cjk noto-fonts-emoji


# AUR packages
sudo -u drace bash $script_dir/paru-config.sh
if command -v paru &> /dev/null; then
    echo "Continue."
else
    echo "Error: paru is not installed."
    exit 1
fi

sudo -u drace paru -S --needed librewolf-bin abook


# sudo flatpak install -y spotify
# sudo flatpak install -y kdenlive

sudo systemctl enable gdm
#/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
#sleep 5
#sudo reboot

