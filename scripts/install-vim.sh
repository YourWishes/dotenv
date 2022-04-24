#!/bin/bash
cd ./scripts

mkdir -p ~/.config/nvim

# Install Plugin Manager
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
cp ./vimrc-plugins ~/.config/nvim/init.vim
vim +"PlugInstall --sync" +qa

# Setup Configuration
cat ./vimrc-config >> ~/.config/nvim/init.vim

# Alias NEOVIM
echo "alias vim='nvim'" >> ~/.bashrc