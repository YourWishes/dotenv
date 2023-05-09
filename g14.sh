#!/bin/bash

# Disable running as root.
if [[ "$EUID" -eq 0 ]]; then
  echo "Please do not run as root"
  exit 1
fi

if grep -q 'g14' "/etc/pacman.conf"; then
    echo 'Pacman already contains G14 repo, skipping'
else
    sudo pacman-key --recv-keys 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
    sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
    sudo pacman-key --lsign-key 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35
    sudo pacman-key --finger 8F654886F17D497FEFE3DB448B15A6B0E9A3FA35

    wget "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x8b15a6b0e9a3fa35" -O g14.sec
    sudo pacman-key -a g14.sec

    echo '[g14]' | sudo tee -a /etc/pacman.conf
    echo 'Server = https://arch.asus-linux.org' | sudo tee -a /etc/pacman.conf
fi

sudo pacman -Syuu
sudo pacman -S -q --noconfirm asusctl supergfxctl rog-control-center
sudo systemctl enable --now power-profiles-daemon.service
sudo systemctl enable --now supergfxd