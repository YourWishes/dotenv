#!/bin/bash
\curl -sSL https://get.rvm.io | bash
source $HOME/.rvm/scripts/rvm
rvm install 2.7.5
rvm use 2.7.5 --default
echo "[[ -s \"$HOME/.rvm/scripts/rvm\" ]] && source \"$HOME/.rvm/scripts/rvm\" # Load RVM into a shell session *as a function*" >> $HOME/.bashrc