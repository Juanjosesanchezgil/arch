#!/bin/bash
# -*- ENCODING: UTF-8 -*-

echo -------------------------
echo Unidad para isntalar
echo -------------------------

fdisk -l
read -p "Introduce la unidad de la instalacion " unidad

echo -------------------------
echo Sistema de particiones
echo -------------------------

mkfs.ext4 /dev/"$unidad"3
mkfs.ext4 /dev/"$unidad"4
mkfs.fat -F 32 /dev/"$unidad"1
mkswap /dev/"$unidad"2

read -rsp $'Press enter to continue...\n'

echo -------------------------
echo Montando particiones
echo -------------------------

mount /dev/"$unidad"3 /mnt
mount --mkdir /dev/"$unidad"1 /mnt/boot
mount --mkdir /dev/"$unidad"4 /mnt/home
swapon /dev/"$unidad"2

echo -------------------------
echo Instalando paquetes
echo -------------------------

pacstrap -K /mnt base base-devel linux linux-firmware nano intel-ucode 

echo -------------------------
echo Instalando el sistema
echo -------------------------

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt pacman -Syu

#pacman -Syu
arch-chroot /mnt pacman -S xorg i3-wm pulseaudio networkmanager grub efibootmgr alacritty dbeaver git i3status intellij-idea-community-edition lightdm lightdm-gtk-greeter network-manager-applet nitrogen nm-connection-editor papirus-icon-theme picom rofi seahorse vlc unzip

# echo -------------------------
# echo Opciones de localizacion
# echo -------------------------

# ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime

# hwclock --systohc

# nano /etc/locale.gen

# locale-gen

# echo -------------------------
# echo Opciones de usuario
# echo -------------------------

# echo -------------------------
# echo Clave usuario root
# echo -------------------------

# passwd

# echo -------------------------
# echo Introduce nombre de usuario
# echo -------------------------

# read usuario


# useradd -m $usuario

# echo -------------------------
# echo Clave usuario $usuario
# echo -------------------------

# passwd $usuario

# usermod -aG wheel,audio,video,storage $usuario

# echo LANG=es_ES.UTF-8 >> /etc/locale.conf
# echo KEYMAP=es >> /etc/vconsole.conf
# echo arch >> /etc/hostname
# echo "127.0.0.1 localhost
# ::1 localhost
# 127.0.1.1 arch" >> /etc/hosts

# echo -------------------------
# echo Activar servicios
# echo -------------------------

# systemctl enable NetworkManager.service
# systemctl enable lightdm.service


# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg -si --noconfirm
# cd ..
# rm -rf yay

# yay -S google-chrome
# yay -S visual-studio-code-bin

# echo "setxkbmap es" >> /home/"$usuario"/.xprofile


