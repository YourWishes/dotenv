#!/bin/bash

# Disable running as root.
if [[ "$EUID" -eq 0 ]]; then
  echo "Please do not run as root"
  exit 1
fi

echo -e "\n\n\nPerforming Upgrades\n\n\n"

# Update, run twice incase of keychain updates
sudo pacman -Syuu -q --noconfirm
sudo pacman -Syuu -q --noconfirm

flatpak update --assumeyes
flatpak update --assumeyes

# Create directories I use.
echo -e "\n\n\nCreating directories\n\n\n"
mkdir -p ~/Applications
mkdir -p ~/htdocs
mkdir -p ~/.config/nvim

# Install the tools I like to use in the CLI
echo -e "\n\n\nInstalling CLI Tools\n\n\n"
sudo pacman -S -q --noconfirm \
  base-devel \
  unrar \
  git \
  cmake \
  curl \
  wget \
  xdg-desktop-portal-kde \
  flatpak \
  neovim \
  vim \
  fuse \
  arch-wiki-docs \
  ntfs-3g \
  p7zip \
  docker \
  docker-compose

# Desktop Programs
echo -e "\n\n\nInstalling Pacman Desktop Programs\n\n\n"
sudo pacman -S -q --noconfirm \
  gparted \
  solaar \
  plasma-wayland-session \
  zip \
  ttc-iosevka \
  bluedevil \
  noto-fonts \
  noto-fonts-cjk \
  noto-fonts-emoji \
  avahi \
  nss-mdns \
  kdeconnect \
  spectacle \
  shotgun \
  xclip \
  cups \
  print-manager \
  libpaper \
  ghostscript \
  sddm \
  gnome-keyring

# Install programs using flatpak
echo -e "\n\n\nInstalling FlatPak Desktop Programs\n\n\n"
flatpak install \
    flathub \
    org.mozilla.firefox \
    com.valvesoftware.Steam \
    com.bitwarden.desktop \
    com.obsproject.Studio \
    dev.vencord.Vesktop \
    app.organicmaps.desktop \
    org.libretro.RetroArch \
    org.gnome.NetworkDisplays \
    org.gnome.gitlab.YaLTeR.VideoTrimmer \
    com.uploadedlobster.peek \
    com.github.PintaProject.Pinta \
    org.qbittorrent.qBittorrent \
    org.videolan.VLC \
    org.gnome.Cheese \
    org.filezillaproject.Filezilla \
    org.kde.elisa \
    org.kde.knights \
    org.kde.kmines \
    org.kde.ksudoku \
    org.kde.kpat \
    fr.handbrake.ghb \
    org.audacityteam.Audacity \
    org.blender.Blender \
    org.mapeditor.Tiled \
    org.libreoffice.LibreOffice \
    org.kde.kalk \
    com.nextcloud.desktopclient.nextcloud \
    org.kde.kdenlive \
    com.github.tchx84.Flatseal \
    io.dbeaver.DBeaverCommunity \
    io.github.mightycreak.Diffuse \
    com.unity.UnityHub \
    com.github.k4zmu2a.spacecadetpinball \
    org.prismlauncher.PrismLauncher \
    net.openra.OpenRA \
    net.rpcs3.RPCS3 \
    org.yuzu_emu.yuzu \
    info.cemu.Cemu \
    org.kde.ksudoku \
    org.kde.krita \
    org.inkscape.Inkscape \
    org.kde.gwenview \
    com.google.Chrome \
    org.godotengine.Godot \
    dev.goats.xivlauncher \
    re.chiaki.Chiaki \
    --assumeyes

# PIA
echo -e "\n\n\nInstalling Private Internet Access\n\n\n"
if ! command -v piactl &> /dev/null
then
  wget https://installers.privateinternetaccess.com/download/pia-linux-3.3.1-06924.run -O ~/Downloads/pia.run
  chmod +x ~/Downloads/pia.run
  mkdir -p ~/.config/privateinternetaccess
  cp ./configs/pia-settings.json ~/.config/privateinternetaccess/clientsettings.json
  ~/Downloads/pia.run
  rm ~/Downloads/pia.run
fi

# YAY (AUR)
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Node JS / NVM
echo -e "\n\n\nNodeJS\n\n\n"
if ! command -v nvm &> /dev/null
then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

nvm install --lts
npm i -g yarn

# VIM
echo -e "\n\n\nVIM\n\n\n"
echo "alias vim='nvim'" >> ~/.bashrc

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
cp ./configs/vimrc-plugins ~/.config/nvim/init.vim
nvim +"PlugInstall --sync" +qa
cat ./configs/vimrc-config >> ~/.config/nvim/init.vim

# Begin Plasma Configurations
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
sudo systemctl enable --now docker

# Qogir
git clone https://github.com/vinceliuice/Qogir-kde
cd Qogir-kde
chmod +x ./install.sh
./install.sh
cd ..

# Fix Dark Mode
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Simp1e Cursors
git clone --recurse-submodules https://gitlab.com/zoli111/simp1e.git
cd simp1e

sudo pacman -S -q --noconfirm \
  librsvg \
  python-pillow \
  xorg-xcursorgen

./build.sh
mkdir ~/.icons
mv ./built_themes/* ~/.icons
cd ..

# Git Config
git config --global user.name Dominic Masters
git config --global user.email dominic@domsplace.com

# Get .local DNS hostnames to work
sudo sed -i 's/hosts\: mymachines resolve/hosts: mymachines resolve mdns_minimal/g' /etc/nsswitch.conf
sudo systemctl stop avahi-daemon
sudo systemctl start avahi-daemon
sudo systemctl enable avahi-daemon

# Printer
sudo systemctl enable --now cups

# Enable plasma env vars
mkdir -p $HOME/.config/plasma-workspace/env/
echo "#!/bin/bash" >> $HOME/.config/plasma-workspace/env/path.sh
echo "export MOZ_ENABLE_WAYLAND=1" >> $HOME/.config/plasma-workspace/env/path.sh

# AUR Packages
yay -S --nodiffmenu \
  visual-studio-code-bin \
  git-credential-manager-core-extras

# Setup VSCode to launch under wayland
echo '--enable-features=WaylandWindowDecorations' >> ~/.config/code-flags.conf
echo '--ozone-platform-hint=auto' >> ~/.config/code-flags.conf

# Shopify stuff
curl -sSL https://get.rvm.io | bash
source $HOME/.rvm/scripts/rvm
rvm install 3.3
rvm use 3.3 --default
npm install -g @shopify/cli @shopify/theme