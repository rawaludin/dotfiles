"******************************************************************************
" Setting: Load Plugin
"******************************************************************************

call plug#begin('~/.config/nvim/plugged')

" ----- Making Vim look good ------------------------------------------
" This one will work with neovim
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'reedes/vim-colors-pencil' " Good theme for light mode and writing

" ----- Vim as a programmer's text editor -----------------------------
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' } | Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat' " Make repeat work on plugin custom command
Plug 'tommcdo/vim-exchange'
Plug 'mattn/emmet-vim'
Plug 'easymotion/vim-easymotion'
Plug 'tomtom/tcomment_vim'
Plug 'terryma/vim-expand-region'
Plug 'chrisbra/Recover.vim' " Diff on recovery from swap file
Plug 'benekastah/neomake' " asynchronous code lint
Plug 'tmux-plugins/vim-tmux-focus-events' " make FocusGained and FocusLost work again in Tmux
Plug 'vim-scripts/BufOnly.vim' " used to close other buffer except the active one with :BufOnly

" ----- Working with PHP ----------------------------------------------
" need this to make pdv work + pdv for phpDocblock
Plug 'tobyS/vmustache' | Plug 'tobyS/pdv'
Plug 'arnaud-lb/vim-php-namespace' " insert php `use` statement automatically  by \u in normal mode
Plug 'jwalton512/vim-blade' " Laravel blade syntax highlighting
Plug 'docteurklein/php-getter-setter.vim' " automate getter and setter

" ----- Working with Git ----------------------------------------------
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" ----- Working with Markdown ----------------------------------------------
" Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/goyo.vim' " distraction mode
Plug 'reedes/vim-colors-pencil' " ia writer inspired theme

" ----- Other text editing features -----------------------------------
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'Shougo/deoplete.nvim' " this one support neovim natively
" Auto generate ctags
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar' " view ctags on sidebar

" ----- Vim for Go Developer -------------------------------------------
Plug 'fatih/vim-go'

call plug#end()
