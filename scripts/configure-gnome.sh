#!/bin/bash

# Gnome Extensions
sudo pacman -S gnome-shell-extensions

# Flat Remix Theme
git clone https://github.com/daniruiz/Flat-Remix-GTK
sudo cp ./Flat-Remix-GTK/themes/* /usr/share/themes

# Iosevka SS09 Variant
sudo pacman -S ttc-iosevka-ss09

# Set theme
gsettings set org.gnome.desktop.interface gtk-theme "Flat-Remix-GTK-Violet-Dark-Solid"