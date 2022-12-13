#!/bin/bash
\curl -sSL https://get.rvm.io | bash
source $HOME/.rvm/scripts/rvm
sudo pacman -S openssl-1.1 -q --noconfirm
rvm pkg install openssl
rvm install 2.7.5 --with-openssl-dir=$HOME/.rvm/usr
rvm use 2.7.5 --default
echo "[[ -s \"$HOME/.rvm/scripts/rvm\" ]] && source \"$HOME/.rvm/scripts/rvm\" # Load RVM into a shell session *as a function*" >> $HOME/.bashrc