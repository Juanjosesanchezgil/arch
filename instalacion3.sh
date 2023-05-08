#!/bin/bash
# -*- ENCODING: UTF-8 -*-

echo -------------------------
echo YAY y AUR
echo -------------------------

yay -S google-chrome visual-studio-code-bin --noconfirm

chsh /bin/zsh

modprobe vboxdrv

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

