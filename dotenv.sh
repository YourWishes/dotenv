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

./scripts/install-node.sh