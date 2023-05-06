#!/bin/bash
# -*- ENCODING: UTF-8 -*-
echo "
-------------------------------------
 Instalador automatico personalizado
-------------------------------------
"
fdisk -l
echo "
 ¿En que unidad deseas intalar?: 
-------------------------------------
"
contador=0
while [[ true ]]
do
  ((contador+=1))
  unidad=$(fdisk -l | grep "Disk /dev/" | awk 'NR=='$contador'{print $0}' | awk {'print $2'} | cut -d '/' -f3 | cut -d ':' -f1)
  if [[ -z "$unidad" ]]
  then
      break
  fi
  if [[ $unidad == sd* ]] || [[ $unidad == nvme* ]]
  then
    echo "$contador" "$unidad"
  fi
done
echo 
read -p "Introduce el numero: " contador
echo

unidad=$(fdisk -l | grep "Disk /dev/" | awk 'NR=='$contador'{print $0}' | awk {'print $2'} | cut -d '/' -f3 | cut -d ':' -f1)

# Automatizar particionado
cfdisk /dev/"$unidad"

fdisk -l | grep $unidad

echo "
read -p "¿Es una instalacion multiboot? s/n" arranque
----------------------------------------------
"

echo -------------------------
echo Sistema de particiones
echo -------------------------


if [[ $arranque =~ ^(S|s)$ ]]
then
  mkswap /dev/"$unidad"p1
  mkfs.ext4 /dev/"$unidad"p2
  mkfs.ext4 /dev/"$unidad"p3
  
  echo -------------------------
  echo Montando particiones
  echo -------------------------
  
  swapon /dev/"$unidad"p1
  mount /dev/"$unidad"p2 /mnt
  mount --mkdir /dev/"$unidad"p3 /mnt/home
  
  echo -------------------------
  echo Opciones particion Boot
  echo -------------------------
  
  fdisk -l
  unidad=$(fdisk -l | grep "EFI System" | awk 'NR=='1'{print $0}' | awk {'print $2'} | cut -d '/' -f3 | cut -d ':' -f1)
  #read -p "Escribe el nombre de la particion donde se encuentra el arranque de Windows " particion
  mount --mkdir /dev/"$particion" /mnt/boot
else

  mkswap /dev/"$unidad"p2
  mkfs.ext4 /dev/"$unidad"p3
  mkfs.ext4 /dev/"$unidad"p4
  
  echo -------------------------
  echo Montando particiones
  echo -------------------------
  
  swapon /dev/"$unidad"p2
  mount /dev/"$unidad"p3 /mnt
  mount --mkdir /dev/"$unidad"p4 /mnt/home
  
  echo -------------------------
  echo Opciones particion Boot
  echo -------------------------
  
  mkfs.fat -F 32 /dev/"$unidad"p1
  mount --mkdir /dev/"$unidad"p1 /mnt/boot
fi

exit

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
