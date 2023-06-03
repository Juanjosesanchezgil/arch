#!/bin/bash
# -*- ENCODING: UTF-8 -*-
alacritty
sudo pacman -Syu
sudo pacman -S arandr dbeaver github-cli htop i3lock i3status libreoffice-fresh neofetch network-manager-applet nitrogen nm-connection-editor ntfs-3g papirus-icon-theme pavucontrol pcmanfm picom ranger rofi seahorse udiskie unzip vlc virtualbox virtualbox-host-modules-arch volumeicon xarchiver xautolock zsh --noconfirm


echo -------------------------
echo YAY y AUR
echo -------------------------

cd ~
cp -rf /arch/.config .config 
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

git clone https://github.com/jluttine/rofi-power-menu.git .config/.rofi-power-menu


yay -S google-chrome visual-studio-code-bin --noconfirm

chsh /bin/zsh

modprobe vboxdrv

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

sed -i 's/plugins=(git)/plugins=(\n \git\n \zsh-autosuggestions\n \zsh-syntax-highlighting\n \)/g' .zshrc

