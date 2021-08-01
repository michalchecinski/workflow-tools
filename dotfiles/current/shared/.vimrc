set ts=4
set sts=4
set shiftwidth=4
set et

set number
set ruler

set tw=120

colorscheme ron

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


set nocompatible "vim-polygot


"plugins
call plug#begin(data_dir . '/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
call plug#end()


"key-bindings
map <C-n> :NERDTreeToggle<CR>
