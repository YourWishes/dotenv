#!/bin/bash

# Create applications directory
mkdir -p ~/Applications

# Install APT Software
sudo apt install --assume-yes vlc firefox pinta font-viewer cheese peek gparted elisa meld filezilla obs-studio obs-plugins
# Not used: sudo apt install inkscape krita

# Install Solaar (For MXM3 Mouse)
sudo apt install --assume-yes solaar

# Install snap Software
sudo snap install bitwarden discord spectacle
sudo snap connect discord:system-observe

# Install WINE
sudo apt install --assume-yes wine winetricks

# pCloud
wget https://p-def4.pcloud.com/cBZML0tunZ9jjz8wZZZFvXMi7Z2ZZmNzZkZg7ypVZHZSRZtFZtpZ57ZXHZoHZPFZTVZLzZozZhHZ2zZ2HZhAHEXZxgwQ3MSgNgHdl8yODbBr4yYhuDYy/pcloud -O ~/Applications/pcloud
chmod +x ~/Applications/pcloud

# VS Code
wget https://az764295.vo.msecnd.net/stable/899d46d82c4c95423fb7e10e68eba52050e30ba3/code_1.63.2-1639562499_amd64.deb -O ~/Downloads/vscode.deb
sudo dpkg -i ~/Downloads/vscode.deb
rm ~/Downloads/vscode.deb

# PIA
wget https://installers.privateinternetaccess.com/download/pia-linux-3.2-06857.run -O ~/Downloads/pia.run
chmod +x ~/Downloads/pia.run
mkdir -p ~/.config/privateinternetaccess
cp ./scripts/pia-settings.json ~/.config/privateinternetaccess/clientsettings.json
~/Downloads/pia.run
rm ~/Downloads/pia.run

# Begin KDE Configuration!
#mkdir -p ./backups
#cp ~/.config/plasma-org.kde.plasma.desktop-appletsrc ./backups/plasma-org.kde.plasma.desktop-appletsrc
#kquitapp5 plasmashell
#cp ./scripts/kde-config ~/.config/plasma-org.kde.plasma.desktop-appletsrc
#kstart5 plasmashell