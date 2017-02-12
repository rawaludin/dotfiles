"******************************************************************************
" Setting: Keys Combination
"******************************************************************************

" Key: General Leader Key Binding ----
"
" Set leader key to space 
let mapleader = " "
" quit by <space>q
nmap <silent> <leader>q :q<CR>
" force quit by <space>qq
nmap <silent> <leader>qq :q!<CR>
" save by <space>w
nmap <silent> <leader>w :w<CR>
" save and quit by <space>wq
nmap <silent> <leader>wq :wq<CR>
" edit vimrc file by <space>v
nmap <leader>v :edit $MYVIMRC<CR>
" -----------------------------------------------------------------------------


" Key: Buffer Management ----
"
" Copy current buffer path relative to root of VIM session to system clipboard
nnoremap <Leader>yp :let @*=expand("%")<cr>:echo "Copied file path to clipboard"<cr>
" Copy current filename to system clipboard
nnoremap <Leader>yf :let @*=expand("%:t")<cr>:echo "Copied file name to clipboard"<cr>
" Copy current buffer path without filename to system clipboard
nnoremap <Leader>yd :let @*=expand("%:h")<cr>:echo "Copied file directory to clipboard"<cr>
" undo close buffer by <Ctrl><shift>t
map <silent> <C-T> :e #<CR>
" new empty buffer by space+n (useful for tinkering script)
nnoremap <silent> <leader>n :enew<cr>
set splitbelow
" new empty buffer at bottom
nnoremap <silent> <C-w>- :sp<cr>
set splitright
" new empty buffer at right
nnoremap <silent> <C-w>\ :vsp<cr>
" -----------------------------------------------------------------------------


" Key: Custom Binding ----
"
" redraw syntax, clear search highlight by <space>l
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr>:Strip<cr>:w<cr><c-l>
" select last pasted block by `gp`
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" sudo when save with :w!!
cmap w!! w !sudo tee > /dev/null %<CR>
" -----------------------------------------------------------------------------


" Key: Text bubling (move line up/down) ----
"
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
" Make buble multiple lines work inside tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
" -----------------------------------------------------------------------------
