set ts=4
set sts=4
set shiftwidth=4
set et

set number
set ruler

set tw=120

colorscheme ron

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


set nocompatible "vim-polygot

"plugins
call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
call plug#end()


"key-bindings
map <C-n> :NERDTreeToggle<CR>
