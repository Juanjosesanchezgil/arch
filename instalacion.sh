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
mkfs.fat -F 32 /dev/"$unidad"1
mkswap /dev/"$unidad"2

# read -rsp $'Press enter to continue...\n'

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

pacstrap -K /mnt base base-devel linux linux-firmware nano intel-ucode git dos2unix

echo -------------------------
echo Instalando el sistema
echo -------------------------

genfstab -U /mnt >> /mnt/etc/fstab

git clone https://github.com/juanjosesanchezgil/arch.git

chmod a+x instalacion2.sh
dos2unix instalacion2.sh

cp instalacion2.sh /mnt

arch-chroot /mnt ./instalacion2.sh
