#!/bin/bash

# Update
sudo pacman -Syuu -q --noconfirm

# Install
sudo pacman -S -q --noconfirm base-devel unrar git cmake curl wget flatpak neovim vim