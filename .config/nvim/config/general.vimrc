"******************************************************************************
" Setting: General
"******************************************************************************
"
" allow backspacing over everything in insert mode
set ruler                 " show the cursor position all the time
set number                " line numbers
set showcmd               " display incomplete commands
set autowriteall          " save buffer when switch to other buffer
set clipboard+=unnamedplus " share clipboard with OSX
set wrap linebreak nolist " better word wrap
set autoread              " detect latest change outside vim

" Tab
set expandtab             " Expand tabs into spaces
set tabstop=2             " default to 2 spaces for a hard tab
set softtabstop=2         " default to 2 spaces for the soft tab
set shiftwidth=2          " for when <TAB> is pressed at the beginning of a line

" Fold
set foldmethod=indent     " Fold based on indent
set foldnestmax=10        " deepest fold is 10 levels
set nofoldenable          " dont fold by default

set updatetime=250        " change file update time from 4 s to 0.25s for gitgutter
set colorcolumn=81        " column guide at 81 char
set ignorecase            " ignore case on autocomplete command
set hidden                " hide error when opening file but current buffer has
                          " unsaved changes
au FocusLost * silent! wa " autosave when focus is lost, not save unsaved buffer
set shell=zsh             " use zsh as shell, don't forget to ln -s ~/.zshrc ~/.zshenv

" Enable mouse only in normal mode. So my cursor don't accidentally moved when
" my palm touch trackpad
set mouse=n

" Use project based tags beside global tags on ~/.vimtags / ~/tags
" check current tags file in use with `:set tags?`
set tags=tags;

" let $NVIM_TUI_ENABLE_TRUE_COLOR=1  " support true color (enable this when
" tmux support true color)
" different cursor on insert and normal mode (only work for iTerm2)
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" map ; to :
nnoremap ; :

" exit insert when pressing up/down in insert mode
inoremap <silent> <Up> <ESC><Up>
inoremap <silent> <Down> <ESC><Down>

" exit insert when scroll up/down in insert mode
inoremap <silent> <ScrollWheelUp> <ESC><ScrollWheelUp>
inoremap <silent> <ScrollWheelDown> <ESC><ScrollWheelDown>

" color scheme
colorscheme Tomorrow-Night
" colorscheme solarized
" colorscheme pencil

"******************************************************************************
" Setting: Custom Command
"******************************************************************************

" Command: delete all trailing whitespace in current buffer by :strip ----
"
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
command! Strip call <SID>StripTrailingWhitespaces()<CR>
" -----------------------------------------------------------------------------


" Command: sequential increment ----
"
function! Incr()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction
vnoremap <C-a> :call Incr()<CR>
" -----------------------------------------------------------------------------


"******************************************************************************
" Setting: Autocmd Rules
"******************************************************************************

" Autocmd: The PC is fast enough, do syntax highlight syncing from start ----
"
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END
" -----------------------------------------------------------------------------


" Autocmd: Remember cursor position
"
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
" -----------------------------------------------------------------------------


" Autocmd: Cursor Snipper ----
"
set updatetime=2000

function! MySetCursor()
  set cursorline
  set cursorcolumn
endfunction
function! MyUnSetCursor()
  set nocursorline
  set nocursorcolumn
endfunction

au! CursorHold * call MyUnSetCursor()
au! CursorMoved * call MySetCursor()
au! CursorMovedI * call MyUnSetCursor()
" -----------------------------------------------------------------------------
