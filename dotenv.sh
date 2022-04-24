#!/bin/bash

# Disable running as root.
if [[ "$EUID" -eq 0 ]]; then
  echo "Please do not run as root"
  exit 1
fi

# Grant SH execute
chmod +x ./**/*.sh

# Setup SSH key
mkdir -p ~/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAhF9DPXFN207BJrScSdWCMP+S5iOHKa/9KRBSMx4iqcc3YgGJttgMdTqrlJwTKDZgxmzc9LSBGJlkY5fQaYRyH4kRTaBs6oyYbEeo9b85NF8NZ1cpeMA3qORRIkWlDeSYIBhPmwORqPJjXDIEp04eza/ujZmOLGO412h4+Z6RLjUq7gdQEB9o9v9hz/9rV+0IRhie4PumffWZ94ZyAixrgsUGJqDyfLo+mTSEgXOYAJgvqfZ5+q3tke2MraGVmjZhinBfUZp608VqA56bG6KRvJX1uz8TGuReG4UCiWQX/waTxJRc80FySjnR7+1uzB7OwGWtiN0B6/lOd2Gt8QufKQ== rsa-key-20190523" >> ~/.ssh/authorized_keys
chmod 0700 ~/.ssh/authorized_keys

# Arch Linux Setup
if [ -f "/etc/arch-release" ]; then
  ./scripts/install-arch.sh
fi

# Debian set up
if [ -f "/etc/debian_version" ]; then
  ./scripts/install-debian.sh
fi

# Update flatpak
flatpak update --assumeyes

# Node JS / NVM
./scripts/install-node.sh
source ~/.nvm/nvm.sh

# Ruby / RVM
./scripts/install-rvm.sh
source ~/.rvm/scripts/rvm

# VIM
./scripts/install-vim.sh

# Plasma Desktop
if [[ "$DESKTOP_SESSION" -eq "plasma" ]]; then
  ./scripts/install-plasma.sh
fi

# Iosevka
