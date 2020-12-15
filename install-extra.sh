#!/usr/bin/sh
# Install GoLang
pacman -Sy go

# Install cordless
git clone https://github.com/Bios-Marcel/cordless.git
cd cordless
go build