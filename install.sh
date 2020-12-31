#!/usr/bin/sh

# Install VIM
pacman -Sy --noconfirm vim

# Install Screen
pacman -Sy --noconfirm screen

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Install NodeJS
nvm install --lts

# Install Yarn
npm i -g yarn

# Install rTorrent
pacman -Sy --noconfirm rtorrent
cp ./configurations/rtorrent.rc ~/.rtorrent.rc

# RAR
pacman -Sy --noconfirm unrar

# GCC
pacman -Sy --noconfirm base-devel