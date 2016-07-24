"
"          ██                           
"         ░░                            
" ██    ██ ██ ██████████  ██████  █████ 
"░██   ░██░██░░██░░██░░██░░██░░█ ██░░░██
"░░██ ░██ ░██ ░██ ░██ ░██ ░██ ░ ░██  ░░ 
" ░░████  ░██ ░██ ░██ ░██ ░██   ░██   ██
"  ░░██   ░██ ███ ░██ ░██░███   ░░█████ 
"   ░░    ░░ ░░░  ░░  ░░ ░░░     ░░░░░  
"
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

" ======== Vim-plug settings ========
" set the runtime path to include Vim-plug and initialize
call plug#begin("~/.config/nvim/bundle")

" Colors
Plug 'chriskempson/base16-vim'
" Syntax & autocomplete stuff
Plug 'scrooloose/syntastic'
"Plug 'Valloric/YouCompleteMe'
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
" C language
Plug 'Rip-Rip/clang_complete'
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
" Javascript & node
Plug 'ternjs/tern_for_vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'moll/vim-node'
Plug 'walm/jshint.vim'
" Python
Plug 'davidhalter/jedi-vim'
" HTML & CSS
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'digitaltoad/vim-pug'
" Lisp
Plug 'kovisoft/slimv'
" Golang
Plug 'fatih/vim-go'
Plug 'vim-jp/vim-go-extra'
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
" Various
"Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'tpope/vim-surround'
" interface and utilities
Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'Townk/vim-autoclose'
Plug 'terryma/vim-multiple-cursors'
Plug 'godlygeek/tabular'
"Plug 'vim-scripts/utl.vim'
"Plug 'jceb/vim-orgmode'
" Snippets
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'
"Plug 'honza/vim-snippets'
" Fancy things
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'https://github.com/vim-scripts/vimwiki.git'
"Plug 'edkolev/tmuxline.vim'

" All of your Plugs must be added before the following line
call plug#end()            " required

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
"colorscheme seti
" transparent background
hi Normal ctermbg=none

" Setting a different <leader>
let  mapleader = ','

" ======== Options for markdown text ========
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.txt set filetype=markdown

" ======== allow css and sass autocomple ========
set omnifunc=csscomplete#CompleteCSS
"autocmd BufNewFile,BufRead *.scss set ft=scss.css<Paste>

" ======== NERDTree options ========
"autocmd vimenter * if !argc() | NERDTree | endif
map <C-t> :NERDTreeToggle<CR>
" Close vim when a file is closed and NERDTree is the last open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Autoloading NERDTree when opening a file
"autocmd vimenter * NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" set NERDTree arrows
"let g:NERDTreeDirArrowExpandable = '+'
"let g:NERDTreeDirArrowCollapsible = '-'
"
"
" ======== YouCompleteMe settings =========
"let g:ycm_auto_stop_csharp_server = 1
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"
" ======== Deoplete settings ===========
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" ======== Python Jedi settings ========
"let g:jedi#auto_vim_configuration = 0

" ======== Syntastic settings ========
" Set checkers for syntastic:
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_css_checkers = ['csslint']
let g:syntastic_python_checkers = ['pylint']
autocmd bufwritepost *.js silent !standard-format -w %
set autoread

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
let g:airline#extensions#tabline#left_alt_sep = '░'
" Disable powerline arrows and setting blank seperators creates a rectangular box
let g:airline_left_sep = '█▓░'
let g:airline_right_sep = '░▓█'

" ========= vim-nodejs-complete settings =========
let g:nodejs_complete_config = {
\  'js_compl_fn': 'jscomplete#CompleteJS',
\  'max_node_compl_len': 15
\}

" ========== Goyo settings ===========
let g:goyo_width = 120
