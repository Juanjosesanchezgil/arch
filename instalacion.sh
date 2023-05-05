#!/bin/bash
# -*- ENCODING: UTF-8 -*-

echo -------------------------------------
echo Instalador automatico personalizado
echo -------------------------------------

fdisk -l
unidad = ""
contador = 0
while [[ ! "$unidad" =~ "loop0"]]
do
  contador ++
  unidad=$(fdisk -l | grep /dev/ | awk 'NR==1{print $0}' | awk {'print $2'} | cut -d '/' -f3 | cut -d ':' -f1)
  echo "$unidad""$contador"
done

exit

echo -------------------------------------
echo Unidad para instalar
echo -------------------------------------

read -p "¿Vas a instalar en M.2? s/n " ssd
while [[ ! "$ssd" =~ ^(S|s|N|n)$ ]]
do
  read -p "¿Vas a instalar en M.2? s/n " ssd
done

if [[ $ssd =~ ^(S|s)$ ]]
then
  fdisk -l
  unidad=$(fdisk -l | grep Disco | awk {'print $2'} | cut -d '/' -f3 | cut -d ':' -f1)
  #unidad=nvme
 else
  fdisk -l
  unidad=$(fdisk -l | grep Disco | awk {'print $2'} | cut -d '/' -f3 | cut -d ':' -f1)
  #unidad=sd
fi

exit

cfdisk /dev/"$unidad"

echo -------------------------
echo Sistema de particiones
echo -------------------------

read -p "¿Es una instalacion multiboot? s/n" arranque

if [[ $arranque =~ ^(S|s)$ ]]
then
  mkswap /dev/"$unidad"1
  mkfs.ext4 /dev/"$unidad"2
  mkfs.ext4 /dev/"$unidad"3
  
  echo -------------------------
  echo Montando particiones
  echo -------------------------
  
  swapon /dev/"$unidad"1
  mount /dev/"$unidad"2 /mnt
  mount --mkdir /dev/"$unidad"3 /mnt/home
  
  echo -------------------------
  echo Opciones particion Boot
  echo -------------------------
  
  fdisk -l
  read -p "Escribe el nombre de la particion donde se encuentra el arranque de Windows " particion
  mount --mkdir /dev/"$particion" /mnt/boot
else

  mkswap /dev/"$unidad"2
  mkfs.ext4 /dev/"$unidad"3
  mkfs.ext4 /dev/"$unidad"4
  
  echo -------------------------
  echo Montando particiones
  echo -------------------------
  
  swapon /dev/"$unidad"2
  mount /dev/"$unidad"3 /mnt
  mount --mkdir /dev/"$unidad"4 /mnt/home
  
  echo -------------------------
  echo Opciones particion Boot
  echo -------------------------
  
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
