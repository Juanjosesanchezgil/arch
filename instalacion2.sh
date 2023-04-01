#!/bin/bash
# -*- ENCODING: UTF-8 -*-

pacman -Sy

pacman -S xorg i3-wm pulseaudio networkmanager grub efibootmgr alacritty dbeaver htop ranger pcmanfm neofetch git i3status intellij-idea-community-edition lightdm lightdm-gtk-greeter network-manager-applet nitrogen nm-connection-editor papirus-icon-theme picom rofi seahorse vlc unzip ntfs-3g udiskie libreoffice-fresh os-prober unzip arandr noto-fonts ttf-dejavu volumeicon ttf-liberation postgresql pavucontrol github-cli i3lock xautolock --noconfirm

echo -------------------------
echo Opciones de localizacion
echo -------------------------

ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime

hwclock --systohc

sed -i 's/#es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/g' /etc/locale.gen

locale-gen

echo LANG=es_ES.UTF-8 >> /etc/locale.conf
echo KEYMAP=es >> /etc/vconsole.conf

echo -------------------------
echo Opciones de usuario
echo -------------------------

echo -------------------------
echo Clave usuario root
echo -------------------------

passwd

echo -------------------------
echo Introduce nombre de usuario
echo -------------------------

read usuario


useradd -m $usuario

echo -------------------------
echo Clave usuario $usuario
echo -------------------------

passwd $usuario

usermod -aG wheel,audio,video,storage $usuario

sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g' /etc/sudoers

read -p "Introduce el nombre de tu host " host

echo $host >> /etc/hostname
echo "127.0.0.1 localhost
::1 localhost
127.0.1.1 $host " >> /etc/hosts

echo -------------------------
echo Activar servicios
echo -------------------------

systemctl enable NetworkManager.service
systemctl enable lightdm.service

echo -------------------------
echo Instalando arranque
echo -------------------------

grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg

echo -------------------------
echo Opciones de configuracion
echo -------------------------

echo "setxkbmap es &
nm-applet &
udiskie -t &
volumeicon &" >> /home/"$usuario"/.xprofile

cd /home/$usuario/

git clone https://github.com/jluttine/rofi-power-menu.git .rofi-power-menu

cd /

cp -rf .config /home/"$usuario"/

rm -rf instalacion*.sh
rm -rf .config
rm -rf yay-11.3.2-1-x86_64.pkg.tar.zst

chown -R $usuario /home/$usuario/
chgrp -R $usuario /home/$usuario/

read -rsp $'Press enter to continue...\n'

su juanj ./instalacion3.sh





