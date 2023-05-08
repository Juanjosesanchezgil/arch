#!/bin/bash
# -*- ENCODING: UTF-8 -*-

echo -------------------------
echo YAY y AUR
echo -------------------------

yay -S google-chrome visual-studio-code-bin --noconfirm

chsh /bin/zsh

modprobe vboxdrv

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

sed -i 's/plugins=(git)/plugins=(\n \git\n \zsh-autosuggestions\n \)/g' .zshrc

