#!/bin/bash

# Disable running as root.
if [[ "$EUID" -eq 0 ]]; then
  echo "Please do not run as root"
  exit 1
fi

# Grant SH execute
chmod +x ./**/*.sh

# Arch Linux Setup
if [ -f "/etc/arch-release" ]; then
  ./scripts/install-arch.sh
fi

# Debian set up
if [ -f "/etc/debian_version" ]; then
  ./scripts/install-debian.sh
fi

# Node JS
./scripts/install-node.sh
source ~/.nvm/nvm.sh

# Install VIM Settings
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp ./scripts/.vimrc ~/.vimrc
vim -c "PlugInstall"