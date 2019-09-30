#!/bin/bash

# Install system packages
sudo pacman -s reflector
sudo reflector --verbose --latest 16 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syu --noconfirm --needed base-devel rsync zsh hub python python-pip python2 python2-pip ruby vim go yarn ruby the_silver_searcher tmux

# Setup yay for installing from AUR
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd

# Install AUR packages
yay -S --noconfirm --needed fpp perl-extract-url cquery msodbcsql mssql-tools

# Change default shell
sudo chsh vagrant -s /bin/zsh

# install vim plugins
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +'PlugInstall --sync' +'UpdateRemotePlugins --sync' +qa
