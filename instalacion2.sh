#!/bin/bash
# -*- ENCODING: UTF-8 -*-

pacman -Sy

pacman -S xorg i3-wm pulseaudio networkmanager grub efibootmgr alacritty dbeaver git i3status intellij-idea-community-edition lightdm lightdm-gtk-greeter network-manager-applet nitrogen nm-connection-editor papirus-icon-theme picom rofi seahorse vlc unzip ntfs-3g udiskie libreoffice-fresh os-prober unzip arandr noto-fonts pavucontrol ttf-dejavu volumeicon ttf-liberation postgresql pgadmin4 --noconfirm

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

git clone https://github.com/jluttine/rofi-power-menu.git ~/.rofi-power-menu

cd $HOME
mkdir .config
cd .config
mkdir i3

cp config /home/"$usuario"/.config/i3/

read -rsp $'Press enter to continue...\n'

#./instalacion3.sh





