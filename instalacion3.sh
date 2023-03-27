#!/bin/bash
# -*- ENCODING: UTF-8 -*-

echo -------------------------
echo Opciones de configuracion
echo -------------------------

echo "setxkbmap es &
nm-applet &
udiskie -t &
volumeicon &" >> /home/"$usuario"/.xprofile

cd /home/"$usuario"/

git clone https://github.com/jluttine/rofi-power-menu.git .rofi-power-menu

cp config /home/"$usuario"/.config/i3/

read -rsp $'Press enter to continue...\n'
