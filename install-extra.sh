#!/usr/bin/sh
# Install GoLang
pacman -Sy --noconfirm go

# Install cordless
git clone https://github.com/Bios-Marcel/cordless.git
cd cordless
go build