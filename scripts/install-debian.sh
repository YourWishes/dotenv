#!/bin/bash

# Update
sudo apt update
sudo apt upgrade

# Install
sudo apt install --assume-yes build-essential unrar vim git cmake neovim curl wget

echo "alias vim=nvim" >> ~/.bashrc
