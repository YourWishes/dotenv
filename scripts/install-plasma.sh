#!/bin/bash

# Create applications directory
mkdir -p ~/Applications

# Prep snap
#sudo ln -s /var/lib/snapd/snap /snap

toInstall="\
  firefox \
  gparted \
  solaar \
  qbittorrent \
  vlc \
  pinta \
  cheese \
  meld \
  filezilla \
  inkscape \
  gnome-chess \
  gnome-mines \
  gnome-sudoku \
  aisleriot \
  handbrake \
  audacity \
  blender \
  tiled \
  libreoffice-fresh \
  xorg-xcursorgen \
  plasma-wayland-session \
  zip
"

# Arch Linux Setup
if [ -f "/etc/arch-release" ]; then
  sudo pacman -S -q --noconfirm $toInstall

  # VS Code (Arch)
  git clone https://aur.archlinux.org/visual-studio-code-bin
  cd visual-studio-code-bin
  makepkg -si --noconfirm
  cd ..
fi

# Debian set up
if [ -f "/etc/debian_version" ]; then
  sudo apt install --assume-yes $toInstall

  # VS Code (Debian)
  wget https://az764295.vo.msecnd.net/stable/899d46d82c4c95423fb7e10e68eba52050e30ba3/code_1.63.2-1639562499_amd64.deb -O ~/Downloads/vscode.deb
  sudo dpkg -i ~/Downloads/vscode.deb
  rm ~/Downloads/vscode.deb
fi

# Install programs using flatpak
flatpak install flathub \
    com.bitwarden.desktop \
    com.obsproject.Studio \
    com.discordapp.Discord \
    com.usebottles.bottles \
    org.libretro.RetroArch \
    org.gnome.NetworkDisplays \
    org.gnome.gitlab.YaLTeR.VideoTrimmer \
    net.ankiweb.Anki \
    com.orama_interactive.Pixelorama \
    com.parsecgaming.parsec \
    com.github.tenderowl.frog \
    com.uploadedlobster.peek \
    --assumeyes

# pCloud
if [ ! -f "~/Applications/pcloud" ]; then
  wget https://p-def8.pcloud.com/cBZu1eKrMZMqwjTqZZZh9ILr7Z2ZZmNzZkZPF7pVZrHZrzZBpZpRZc5Z6pZopZ9pZApZGFZUJZkJZPpZkzZWTVkVZQDtD9nHvjKu7c1tTLeXYVj05EfNk/pcloud -O ~/Applications/pcloud
  chmod +x ~/Applications/pcloud
  ~/Applications/pcloud &
fi

# PIA
if ! command -v piactl &> /dev/null
then
  wget https://installers.privateinternetaccess.com/download/pia-linux-3.3.1-06924.run -O ~/Downloads/pia.run
  chmod +x ~/Downloads/pia.run
  mkdir -p ~/.config/privateinternetaccess
  cp ./scripts/pia-settings.json ~/.config/privateinternetaccess/clientsettings.json
  ~/Downloads/pia.run
  rm ~/Downloads/pia.run
fi

# Qogir theme
git clone https://github.com/vinceliuice/Qogir-kde
cd Qogir-kde
./install.sh
cd ..

# Iosevka Font
mkdir -p ~/.fonts
wget "https://objects.githubusercontent.com/github-production-release-asset-2e65be/39315600/97e975fb-b154-4b05-bd0a-3c818fdb02f9?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20220424%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220424T063917Z&X-Amz-Expires=300&X-Amz-Signature=4edc659fe314a1f8b8964063152d98f2ce1e1c971619d87c08996443ce65cf68&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=39315600&response-content-disposition=attachment%3B%20filename%3Dsuper-ttc-iosevka-ss09-15.2.0.zip&response-content-type=application%2Foctet-stream" -O ./iosevka-ss09.zip
bsdtar xvf ./iosevka-ss09.zip
mkdir -p ~/.fonts
cp -r ./*.ttc ~/.fonts/

# Papirus Icons
mkdir -p ~/.local/share/icons
wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.local/share/icons" sh
/usr/lib/plasma-changeicons Papirus-Dark

# simp1e cursors
if [ ! -d "simp1e" ] ; then
  git clone --recurse-submodules https://gitlab.com/zoli111/simp1e.git
fi
cd simp1e
find . -type f -name "*.sh" -exec sed -i 's/\r//' {} \;
chmod +x ./generate_svgs.sh
./generate_svgs.sh
./build_cursors.sh
cp -r ./built_themes/* ~/.local/share/icons/
kwriteconfig5 --file ~/.config/kcminputrc --group Mouse --key cursorTheme "Simp1e-"

# Wallpaper

# Kickstart / Start Menu, installed but not configured
if [ ! -d "plasma-kickoff-grid" ] ; then
  git clone https://gitlab.com/nwwdles/plasma-kickoff-grid.git
fi
cd plasma-kickoff-grid
zip -r "plasma-kickoff-grid.plasmoid" package
kpackagetool5 --install "plasma-kickoff-grid.plasmoid"

# TODO:
# Change the blinking animation on opening apps
# Splash Screen
# Screen Edges for desktop
# Touch Screen Gestures*
# Lock Screen settings
# Virtual Desktops
# Task Switcher (Alt Tab)
# Disable
# SDDM
# Autostart
# Dont restore saved session
# Do not disturb mode
# User Icon and email
# Date and time settings, localization settings
# Disable KDE Wallet
# Online accounts (gmail)
# Night Color
# Power save settings
# Printers?
# Application Launcher
# Change tray icons
# Change clock display