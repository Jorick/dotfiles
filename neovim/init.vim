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

" Vim-plug settings {{{
" set the runtime path to include Vim-plug and initialize
call plug#begin("~/.config/nvim/bundle")

" Colors
"Plug 'phanviet/vim-monokai-pro'
Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}
" Deoplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
" Syntax & autocomplete stuff
Plug 'scrooloose/syntastic'
"Neomake
Plug 'neomake/neomake'
" C language
"Plug 'Rip-Rip/clang_complete'
" Javascript & node
Plug 'ternjs/tern_for_vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'moll/vim-node'
Plug 'walm/jshint.vim'
" HTML & CSS
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'digitaltoad/vim-pug'
"" Golang
"Plug 'fatih/vim-go'
"Plug 'vim-jp/vim-go-extra'
"Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
" Rust
" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Completion framework
Plug 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
" See hrsh7th's other plugins for more completion sources!
" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" Various
Plug 'tpope/vim-surround'
" interface and utilities
Plug 'mileszs/ack.vim'
Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'Townk/vim-autoclose'
Plug 'terryma/vim-multiple-cursors'
Plug 'godlygeek/tabular'
" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Fancy stuff
Plug 'junegunn/goyo.vim'
Plug 'https://github.com/vim-scripts/vimwiki.git'
"Plug 'edkolev/tmuxline.vim'

" All of your Plugs must be added before the following line
call plug#end()            " required

" }}}

" General Vim settings {{{
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

set foldmethod=marker

set number

syntax on

set relativenumber

" Setting a different <leader>
let  mapleader = "\<SPACE>"

" }}}

" Color scheme {{{
"let base16colorspace=256
colorscheme gruvbox-baby
"colorscheme seti
" transparent background
hi Normal ctermbg=none

" }}}

"Custom commands {{{

command Deltralingwhite execute "%s/\s\+$//e"

" }}}

" Options for markdown text {{{
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.txt set filetype=markdown

" }}}

" NERDTree options {{{
"autocmd vimenter * if !argc() | NERDTree | endif
map <leader>t :NERDTreeToggle<CR>
" Close vim when a file is closed and NERDTree is the last open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Autoloading NERDTree when opening a file
"autocmd vimenter * NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" set NERDTree arrows
"let g:NERDTreeDirArrowExpandable = '+'
"let g:NERDTreeDirArrowCollapsible = '-'
" }}}

" Rust setting {{{
" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

" }}}

" Syntastic settings {{{
" Set checkers for syntastic:
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_css_checkers = ['csslint']
let g:syntastic_python_checkers = ['pylint']
autocmd bufwritepost *.js silent !standard-format -w %
set autoread

" }}}

" Tmuxline settings {{{
let g:tmuxline_powerline_separators = 1

" }}}

" Tagbar settings {{{
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

" }}}

" Vim-airline settings {{{
set laststatus=2
let g:airline_theme='base16_gruvbox_dark_hard'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '░'
" Disable powerline arrows and setting blank seperators creates a rectangular box
"let g:airline_left_sep = '▓░'
"let g:airline_right_sep = '░▓'

" }}}

" Goyo settings {{{
let g:goyo_width = 120

" }}}

" telescope settings {{{

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" }}}

" Ack settings {{{{{{
let g:ackprg = 'ag --vimgrep'

" }}}}}}
