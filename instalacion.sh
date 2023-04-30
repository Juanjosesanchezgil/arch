#!/bin/bash
# -*- ENCODING: UTF-8 -*-

echo -------------------------
echo Unidad para instalar
echo -------------------------

fdisk -l
read -p "Introduce la unidad de la instalacion sin la particion " unidad

echo -------------------------
echo Sistema de particiones
echo -------------------------

mkfs.ext4 /dev/"$unidad"3
mkfs.ext4 /dev/"$unidad"4
mkswap /dev/"$unidad"2

echo -------------------------
echo Montando particiones
echo -------------------------

mount /dev/"$unidad"3 /mnt
mount --mkdir /dev/"$unidad"4 /mnt/home
swapon /dev/"$unidad"2

echo -------------------------
echo Opciones particion Boot
echo -------------------------

read -p "¿Es una instalacion multiboot? S/N" arranque

if [[ $arranque = s ]] || [[ $arranque = si ]] || [[ $arranque = S ]] || [[ $arranque = Si ]] || [[ $arranque = Y ]]
then
  fdisk -l
  read -p "Escribe el nombre de la particion donde se encuentra el arranque de Windows " particion
  mount --mkdir /dev/"$particion" /mnt/boot
else
  mkfs.fat -F 32 /dev/"$unidad"1
  mount --mkdir /dev/"$unidad"1 /mnt/boot
fi

echo -------------------------
echo Instalando paquetes
echo -------------------------

pacstrap -K /mnt base base-devel linux linux-firmware nano intel-ucode

echo -------------------------
echo Instalando el sistema
echo -------------------------

genfstab -U /mnt >> /mnt/etc/fstab

cp instalacion2.sh /mnt
cp instalacion3.sh /mnt
cp -rf .config /mnt
cp yay-11.3.2-1-x86_64.pkg.tar.zst /mnt

arch-chroot /mnt ./instalacion2.sh

umount -l /mnt

reboot
