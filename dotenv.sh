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
  flatpak \
  neovim \
  vim

# Desktop Programs
echo -e "\n\n\nInstalling Pacman Desktop Programs\n\n\n"
sudo pacman -S -q --noconfirm \
  firefox \
  gparted \
  solaar \
  qbittorrent \
  vlc \
  pinta \
  cheese \
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
  plasma-wayland-session \
  steam \
  zip \
  ttc-iosevka \
  bluedevil \
  noto-fonts \
  noto-fonts-cjk


# Install programs using flatpak
echo -e "\n\n\nInstalling FlatPak Desktop Programs\n\n\n"
flatpak install flathub \
    com.bitwarden.desktop \
    com.obsproject.Studio \
    com.discordapp.Discord \
    com.usebottles.bottles \
    org.libretro.RetroArch \
    org.gnome.NetworkDisplays \
    org.gnome.gitlab.YaLTeR.VideoTrimmer \
    com.orama_interactive.Pixelorama \
    com.uploadedlobster.peek \
    #com.valvesoftware.steam \
    --assumeyes


# VS Code (AUR)
echo -e "\n\n\nInstalling VSCode\n\n\n"
git clone https://aur.archlinux.org/visual-studio-code-bin
cd visual-studio-code-bin
makepkg -si --noconfirm
cd ..


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
systemctl enable bluetooth
systemctl start bluetooth

# Qogir
git clone https://github.com/vinceliuice/Qogir-kde
cd Qogir-kde
chmod +x ./install.sh
./install.sh
cd ..

# Simp1e Cursors
git clone --recurse-submodules https://gitlab.com/zoli111/simp1e.git
cd simp1e

sudo pacman -S -q --noconfirm \
  librsvg \
  python-pillow \
  xorg-xcursorgen

./build.sh
mv ./built_themes/* ~/.icons
cd ..

# Git Config
git config --global user.name Dominic Masters
git config --global user.email dominic@domsplace.com