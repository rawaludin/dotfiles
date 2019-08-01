" vim: set foldmethod=marker foldlevel=0 nomodeline:
"
" plugin
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'lifepillar/vim-gruvbox8'
call plug#end()

" leader mapping
let mapleader = " "
nnoremap <silent> <leader>p :Files<CR>
nnoremap <silent> <leader><Enter> :Buffers<CR>
nnoremap <silent> <leader>q :b#<CR>
" theme
colorscheme gruvbox8
set background=dark
set number relativenumber
set clipboard+=unnamedplus


