#!/bin/bash
sudo pacman -S lxqt xorg-server sddm
echo "exec startlxqt" >> ~/.xinitrc
sudo systemctl enable sddm.service

# Start
sudo systemctl start sddm.service