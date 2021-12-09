call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'blackbirdtheme/vim'
Plug 'sheerun/vim-polyglot'
Plug 'epmor/hotline-vim'

call plug#end()

" Rules
set tabstop=2
set et
%retab!

" Colors
syntax enable
set background=dark
set background=dark
colorscheme blackbird