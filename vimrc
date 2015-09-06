" .vimrc
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

" ======== Vundle settings ========
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Colors
Plugin 'chriskempson/base16-vim'
Plugin 'NLKNguyen/papercolor-theme'
" Syntax & autocomplete stuff
Plugin 'othree/html5.vim'
Plugin 'moll/vim-node'
Plugin 'scrooloose/syntastic'
Plugin 'marijnh/tern_for_vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'Valloric/YouCompleteMe'
Plugin 'walm/jshint.vim'
Plugin 'guileen/vim-node-dict'
Plugin 'PotatoesMaster/i3-vim-syntax'
" interface and utilities
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'Townk/vim-autoclose'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'godlygeek/tabular'
" Fancy things
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'https://github.com/vim-scripts/vimwiki.git'
"Plugin 'edkolev/tmuxline.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" ======== General Vim settings ========
"
" For multi-byte character support (CJK support, for example):
"set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,gb18030,latin1

set tabstop=2       " Number of spaces that a <Tab> in the file counts for.

set shiftwidth=2    " Number of spaces to use for each step of (auto)indent.

set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.

set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.

set showcmd         " Show (partial) command in status line.

set number          " Show line numbers.

set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.

set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.

set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.

set ignorecase      " Ignore case in search patterns.

set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.

set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.

set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).

set textwidth=250    " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.

set formatoptions=c,q,r,t " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode.
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)

set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.

set background=dark " When set to "dark", Vim will try to use colors that look
                    " good on a dark background. When set to "light", Vim will
                    " try to use colors that look good on a light background.
                    " Any other value is illegal.

set mouse=a         " Enable the use of the mouse.

set encoding=utf-8  " Enforce UTF-8 encoding

syntax on

" ======== Set color scheme ========
let base16colorspace=256
colorscheme base16-ocean
" transparent background
hi Normal ctermbg=none

" ======== NERDTree options ========
"autocmd vimenter * if !argc() | NERDTree | endif
map <C-t> :NERDTreeToggle<CR>

" Close vim when a file is closed and NERDTree is the last open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Autoloading NERDTree when opening a file

"autocmd vimenter * NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" ======== Syntastic settings ========
" Set checkers for syntastic:

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_css_checkers = ['csslint']
let g:syntastic_python_checkers = ['pylint']

" ======== Nerdcommenter settings ========
" Setting a different <leader> for nerdcommenter
let  mapleader = ','

" ======== Tmuxline settings ========
let g:tmuxline_powerline_separators = 1

" ======== Tagbar settings ========
" Enable tagbar for CSS
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_css = {
      \ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
    \ }
" ======== Vim-airline settings ========
set laststatus=2
let g:airline_theme='base16'
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '█▓'
" Disable powerline arrows and setting blank seperators creates a rectangular box
let g:airline_left_sep = '█▓░'
let g:airline_right_sep = '░▓█'
