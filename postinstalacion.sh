#!/bin/bash
# -*- ENCODING: UTF-8 -*-

cd ~
git clone https://github.com/jluttine/rofi-power-menu.git .rofi-power-menu

git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
