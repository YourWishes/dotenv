#!/usr/bin/sh

# Install VIM
pacman -Sy vim

# Install Screen
pacman -Sy screen

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
pacman -Sy rtorrent
cp ./configurations/rtorrent.rc ~/.rtorrent.rc

# RAR
pacman -Sy unrar

# GCC
pacman -Sy gcc