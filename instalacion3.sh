#!/bin/bash
# -*- ENCODING: UTF-8 -*-

echo -------------------------
echo YAY y AUR
echo -------------------------

pacman -U yay-11.3.2-1-x86_64.pkg.tar.zst --noconfirm

yay -S google-chrome visual-studio-code-bin --noconfirm

read -rsp $'Press enter to continue...\n'
