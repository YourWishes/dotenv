#!/bin/bash

# Grant SH execute
chmod +x ./**/*.sh

# Disable running as root.
if [[ "$EUID" -eq 0 ]]; then
  echo "Please do not run as root"
  exit 1
fi

# Arch Linux Setup
if [ -f "/etc/arch-release" ]; then
  ./scripts/install-arch.sh
fi

./scripts/install-node.sh