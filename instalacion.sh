#!/bin/bash
# -*- ENCODING: UTF-8 -*-

echo -------------------------
echo Sistema de particiones
echo -------------------------

mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4
mkfs.fat -F 32 /dev/sda1
mkswap /dev/sda2

echo -------------------------
echo Montando particiones
echo -------------------------

mount /dev/sda3 /mnt
mount --mkdir /dev/sda1 /mnt/boot
mount --mkdir /dev/sda4 /mnt/home
swapon /dev/sda2

echo -------------------------
echo Instalando paquetes
echo -------------------------

pacstrap -K /mnt base base-devel linux linux-firmware nano intel-ucode xorg i3-wm pulseaudio networkmanager grub efibootmgr alacritty dbeaver git i3status intellij-idea-community-edition lightdm lightdm-gtk-greater network-manager-applet nitrogen nm-connection-editor papirus-icon-theme picom rofi seahorse vlc unzip

echo -------------------------
echo Instalando el sistema
echo -------------------------

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

echo -------------------------
echo Opciones de localizacion
echo -------------------------

ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime

hwclock --systohc

nano /etc/locale.gen

locale-gen

echo -------------------------
echo Opciones de usuario
echo -------------------------

echo -------------------------
echo Clave usuario root
echo -------------------------

passwd

useradd -m juanj

echo -------------------------
echo Clave usuario juanj
echo -------------------------

passwd juanj

usermod -aG wheel,audio,video,storage

echo LANG=es_ES.UTF-8 >> /etc/locale.conf
echo KEYMAP=es >> /etc/vconsole.conf
echo arch >> /etc/hostname
echo "127.0.0.1 localhost
::1 localhost
127.0.1.1 arch" >> /etc/hosts

echo -------------------------
echo Activar servicios
echo -------------------------

systemctl enable NetworkManager.service
systemctl enable lightdm.service


git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

yay -S google-chrome
yay -S visual-studio-code-bin

echo "setxkbmap es" >> /home/juanj/.xprofile


