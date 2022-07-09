local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- Colors
--Plug 'phanviet/vim-monokai-pro'
Plug 'gruvbox-community/gruvbox'
-- syntac checking
Plug 'scrooloose/syntastic'
-- Auto complete languege server protocol
-- Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

-- Completion framework
Plug 'hrsh7th/nvim-cmp'

-- LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

-- Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lua'

-- See hrsh7th's other plugins for more completion sources!

-- C language
--Plug 'Rip-Rip/clang_complete'
-- Javascript & node
Plug 'ternjs/tern_for_vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'moll/vim-node'
Plug 'walm/jshint.vim'
-- HTML & CSS
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'digitaltoad/vim-pug'
-- Rust
-- To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

-- Snippet engine
Plug 'hrsh7th/vim-vsnip'

-- Various
Plug 'tpope/vim-surround'
-- interface and utilities
--Plug 'mileszs/ack.vim'
Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'Townk/vim-autoclose'
Plug 'terryma/vim-multiple-cursors'
Plug 'godlygeek/tabular'
Plug 'mbbill/undotree'
-- Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
-- Fancy stuff
Plug 'junegunn/goyo.vim'
Plug 'https://github.com/vim-scripts/vimwiki.git'
--Plug 'edkolev/tmuxline.vim'

vim.call('plug#end')
