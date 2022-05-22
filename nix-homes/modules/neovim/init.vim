set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

syntax on
set noerrorbells "no sound effects
set expandtab
set wildmenu 
set smartindent
set rnu relativenumber " relative line number
set nowrap
set smartcase 
set noswapfile "no swap file (vim creates them by default) 
set nobackup "no backup file
set undodir=~/.nvim/undodir
set undofile
set cursorline
set incsearch
set formatoptions-=cro
set background=dark
set et
set ruler

set tabstop=4 
set softtabstop=4 "how many spaces a tab should use
set shiftwidth=4 
set tw=120

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


set nocompatible "vim-polygot

"plugins
call plug#begin('~/.vim/plugged')

"" General
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'

"" Colorscheme
Plug 'gruvbox-community/gruvbox'

"" Misc
Plug 'ledger/vim-ledger'

call plug#end()

" Plugin Configuration
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

let g:SuperTabDefaultCompletionType = '<C-n>'

let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit="~/.vim/UltiSnips"
let g:UltiSnipsSnippetsDir=$HOME . '/.vim/UltiSnips'
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"


" Colors: {{{
augroup ColorschemePreferences
  autocmd!
  " These preferences clear some gruvbox background colours, allowing transparency
  autocmd ColorScheme * highlight Normal     ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight Todo       ctermbg=NONE guibg=NONE
  " Link ALE sign highlights to similar equivalents without background colours
  autocmd ColorScheme * highlight link ALEErrorSign   WarningMsg
  autocmd ColorScheme * highlight link ALEWarningSign ModeMsg
  autocmd ColorScheme * highlight link ALEInfoSign    Identifier
augroup END

" Use truecolor in the terminal, when it is supported
if has('termguicolors')
  set termguicolors
endif

set background=dark
colorscheme gruvbox
" }}}


"key-bindings
map <C-n> :NERDTreeToggle<CR>
