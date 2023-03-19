#!/bin/bash
# -*- ENCODING: UTF-8 -*-

cd /home/"$usuario"/

read -rsp $'Press enter to continue...\n'

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

yay -S google-chrome
yay -S visual-studio-code-bin
