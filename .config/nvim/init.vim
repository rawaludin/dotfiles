
" Author: Rahmat Awaludin <rahmat.awaludin@dmail.com>
"
" How I configure neovim :P


"******************************************************************************
" Setting: Load Plugin
"******************************************************************************

call plug#begin('~/.config/nvim/plugged')

" ----- Making Vim look good ------------------------------------------
" This one will work with neovim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'edkolev/tmuxline.vim' " theme has been generated. No need to sync now.
" Plug 'mhartington/oceanic-next'
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'

" ----- Vim as a programmer's text editor -----------------------------
Plug 'jiangmiao/auto-pairs' " Insert or delete brackets, parens, quotes in pair
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-slash' " Enhancing in-buffer search experience
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] } " faster align
Plug 'mattn/emmet-vim' " faster html tag generation
Plug 'qpkorr/vim-bufkill' " Delete buffer without closing split :BD :BW :BUN
Plug 'scrooloose/nerdtree' " tree view of current project
Plug 'terryma/vim-multiple-cursors'
Plug 'tmux-plugins/vim-tmux-focus-events' " make FocusGained and FocusLost work again in Tmux, this event used for autosave
Plug 'tpope/vim-unimpaired' " faster movement quicklist, loclist, etc with [  ]
Plug 'tpope/vim-commentary' " comment by gc
Plug 'tpope/vim-repeat' " Make repeat work on plugin custom command
Plug 'tpope/vim-surround' " faster surround
Plug 'tpope/vim-eunuch' " Vim sugar for the UNIX shell commands
Plug 'tpope/vim-abolish' " easily search for, substitute, and abbreviate multiple variants of a word
Plug 'vim-scripts/BufOnly.vim' " used to close other buffer except the active one with :BufOnly
Plug 'justinmk/vim-sneak' " Jump to any location specified by two character

" ----- Working with PHP ----------------------------------------------
Plug 'arnaud-lb/vim-php-namespace' " insert php `use` statement automatically  by <Leader>u in normal mode
" Plug 'ludovicchabant/vim-gutentags' " Automatic tag generation when file saved / modified
Plug 'joonty/vdebug'

" ----- Working with Git ----------------------------------------------
Plug 'airblade/vim-gitgutter' " display each line git status
Plug 'tpope/vim-fugitive' " git inside vim
Plug 'tpope/vim-rhubarb' " github extension for fugitive
Plug 'jreybert/vimagit' " Like emacs's magit
Plug 'lambdalisue/gina.vim' " Another git

" ----- Working with Markdown ----------------------------------------------
Plug 'plasticboy/vim-markdown' | Plug  'godlygeek/tabular', { 'for': 'markdown' } " better markdown highlight
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " no distraction mode

" ----- Other text editing features -----------------------------------
Plug 'w0rp/ale' " linter
" Plug 'SirVer/ultisnips' " text snippet
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Autocomplete. this one support neovim natively
" endif
Plug 'kylef/apiblueprint.vim' " syntax highlight for API Blueprint doc
Plug 'vimwiki/vimwiki' " personal note taker
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } " Visualize undotree

" Auto generate ctags
Plug 'majutsushi/tagbar' " view ctags on sidebar

call plug#end()


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
set colorcolumn=81,121    " column guide at 81 and 121 char
set ignorecase            " ignore case on autocomplete command
set smartcase             " If there uppercase in search term, case sensitive again
set hidden                " hide error when opening file but current buffer has
                          " unsaved changes
set lazyredraw            " for faster scrolling
if !has('nvim')
  set hlsearch            " highlight search
endif

set vb                    " disable bell / beep

au FocusLost * silent! wa " autosave when focus is lost, not save unsaved buffer
" TODO: add conditional here
" set shell=zsh             " use zsh as shell, don't forget to ln -s ~/.zshrc ~/.zshenv
if has('nvim')
  set inccommand=split      " live replace feedback in neovim :%s/foo/bar<CR>
endif

" make . work with visually selected lines
vnoremap . :norm.<CR>

" use rg for grep
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" disable menus to save 50ms startup time
let did_install_default_menus = 1
let did_install_syntax_menu = 1

" Enable mouse only in normal mode. So my cursor don't accidentally moved when
" my palm touch trackpad
set mouse=n

" support true color (enable this when tmux support true color)
if (has("termguicolors"))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.
if v:version >= 703
  set undodir=/tmp//,.
endif

" exit insert when pressing up/down in insert mode
inoremap <silent> <Up> <ESC><Up>
inoremap <silent> <Down> <ESC><Down>

" exit insert when scroll up/down in insert mode
inoremap <silent> <ScrollWheelUp> <ESC><ScrollWheelUp>
inoremap <silent> <ScrollWheelDown> <ESC><ScrollWheelDown>

" qq to record macor, Q to replay
nmap Q @q
" make c-n and c-p mimic up and down behaviour on command mode
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" More text-object
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`' ]
    execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
    execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
    execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
    execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor


"******************************************************************************
" Setting: Custom Command
"******************************************************************************

" Command: delete all trailing whitespace in current buffer by :Strip ----
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


" Command: Get current php classname with or without namespace ----
"
function! GetClass(with_namespace)
    " save the view
    let wv = winsaveview()

    " put namespace in @a
    g/namespace/normal! W"ayt;

    " put class in @b
    g/^\s*\(abstract\)*\s*\(interface\|class\)/normal! /\(interface\|class\)<CR>W"byiw

    " restore the view
    call winrestview(wv)

    " return namespace\class or class
    return a:with_namespace ? @a . '\' . @b : @b
endfunction

nnoremap <leader>yc  let @* = GetClass(0)<CR>:echo "Copied class name to clipboard"<CR>
nnoremap <leader>ycn let @* = GetClass(1)<CR>:echo "Copied namespaced class name to clipboard"<CR>
" -----------------------------------------------------------------------------


"******************************************************************************
" Setting: Autocmd Rules
"******************************************************************************

" Automcd: Simple php formatter using php-cs-fixer ----
"
autocmd FileType php noremap <leader>wf :!php-cs-fixer fix "%" <cr><cr>
" -----------------------------------------------------------------------------


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

function! SnipperSetCursor()
  set cursorline
  set cursorcolumn
endfunction
function! SnipperUnSetCursor()
  set nocursorline
  set nocursorcolumn
endfunction

au! CursorHold * call SnipperUnSetCursor()
au! CursorMoved * call SnipperSetCursor()
au! CursorMovedI * call SnipperUnSetCursor()
" -----------------------------------------------------------------------------

" Autocmd: Zoom ----
"
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                  \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>
" -----------------------------------------------------------------------------

"******************************************************************************
" Setting: Keys Combination
"******************************************************************************

" Key: General Leader Key Binding ----
"
" Set leader key to space
let mapleader = " "
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
" previous buffer
nnoremap <silent> [w :bprevious<CR>
" next buffer
nnoremap <silent> ]w :bnext<CR>
" first buffer
nnoremap <silent> {w :bfirst<CR>
" last buffer
nnoremap <silent> }w :blast<CR>
" delete buffer <space>d
map <silent> <leader>d :bd<cr>
" close all buffer <space>bufdo BD
map <silent> <leader>D :bufdo bd<CR>
" Switch between two buffer back and forth by <space>q
nnoremap <leader>q :b#<cr>
" jump to last tab <space>Tab
let g:lasttab = 1
nmap <Leader><Tab> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
" -----------------------------------------------------------------------------


" Key: Custom Binding ----
"
" redraw syntax, clear search highlight by <space>l
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr>:Strip<cr>:w<cr><c-l>
" select last pasted block by gp
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" Use arrow to resize pane
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>
" -----------------------------------------------------------------------------


"******************************************************************************
" Setting: Plugin
"******************************************************************************


" Plugin: terrryma/vim-multiple-cursor ----
"
" When press ESC from insert mode on multiple cursor, back to multiple cursor,
" not regular vim
let g:multi_cursor_exit_from_insert_mode = 0
" -----------------------------------------------------------------------------


" Plugin: junegunn/vim-easy-align ----
"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" -----------------------------------------------------------------------------


" Plugin: vim-airline/vim-airline ----
"
" set theme
" solarized, distinguished, tomorrow, powerlineish, papercolor, raven, silver, ubaryd, zenburn, oceanixtnext
let g:airline_theme = 'gruvbox'
" Always show statusbar
set laststatus=2
" Fancy arrow symbols, requires a patched font
" To install a patched font, run over to
"     https://github.com/abertsch/Menlo-for-Powerline
"
" download all the .ttf files, double-click en them and click "Install"
" Finally, uncomment the next line
let g:airline_powerline_fonts = 1
" Show PASTE if in paste mode
let g:airline_detect_paste=1
" Automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1
" Remove ugly orange triangle on the bottom right
let g:airline_skip_empty_sections = 1
" simple, without powerline
let g:airline_left_sep=''
let g:airline_left_alt_sep='|'
let g:airline_right_sep=''
let g:airline_right_alt_sep='|'
" Disable fileencoding, fileformat
let g:airline_section_y=''
" Disable percentage, line number, column number
let g:airline_section_z=''

" Short form to view display mode
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }
" -----------------------------------------------------------------------------


" Plugin: scrooloose/nerdtree ----
"
" Open/close NERDTree Tabs with <space>t
" nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
nmap <silent> <leader>t :NERDTreeToggle<CR>
" Open synced tree with <space>st
map <silent> <leader>st :NERDTreeFind<CR>
" To have NERDTree always open on startup set this to 2
let g:nerdtree_tabs_open_on_console_startup = 0
" -----------------------------------------------------------------------------


" Plugin: junegunn/fzf ----
"
" fuzzy open file in current project with <space>p
nnoremap <silent> <expr> <leader>p (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
" nmap <silent> <leader>p :Files<CR>
" List recent opened file <space>h
nmap <silent> <leader>h :History<CR>
" Jump to opened file (buffer) with <space><Enter>
nnoremap <silent> <leader><Enter> :Buffers<CR>
" Jump to method or variable/attribute in current file <space>r
nmap <silent> <leader>r :BTags<CR>
" Jumt to lines in current buffer and search for string <space>/
nmap <silent> <leader>/ :BLines<CR>
" Jumt to lines in current buffer and search for string <space>/
nmap <silent> <leader>/ :BLines<CR>
" Change binding for split
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R --language=php --php-kinds=cfit'
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif
" :Rg similiar to :Ag
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
" -----------------------------------------------------------------------------


" Plugin: airblade/vim-gitgutter  ----
"
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1
" -----------------------------------------------------------------------------


" Plugin: mbbill/undotree  ----
"
let g:undotree_WindowLayout = 2
nnoremap U :UndotreeToggle<CR>
" -----------------------------------------------------------------------------


" Plugin: plasticboy/vim-markdown ----
"
let g:vim_markdown_folding_disabled=1 " disable folding because performance,
                " see https://github.com/plasticboy/vim-markdown/issues/162
" disable indent when new paragraph with `o` from list
au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} setlocal indentexpr=''
" Close TOC after click enter on heading link
nnoremap <expr><enter> &ft=="qf" ? "<cr>:lcl<cr>" : (getpos(".")[2]==1 ? "i<cr><esc>": "i<cr><esc>l")
" -----------------------------------------------------------------------------


" Plugin: mattn/emmet-vim ----
"
let g:user_emmet_install_global = 0
autocmd FileType html,css,php,js,jsx EmmetInstall
let g:user_emmet_leader_key='<Tab>'  " autocomplete emmet by <Tab><comma>
" -----------------------------------------------------------------------------


" Plugin: Shougo/deoplete.nvim ----
"
" Always enable (to manual enable :DeopleteEnable / :DeopleteDisable)
" Make sure you have setup ctags for this to work
let g:deoplete#enable_at_startup = 1
" -----------------------------------------------------------------------------


" Plugin: arnaud-lb/vim-php-namespace ----
"
" Press `<space>u` while on the class being used in normal mode to insert `use`
" statement
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

" Press `<space>e` to expand to fully quailified class name
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>
" -----------------------------------------------------------------------------


" Plugin: edkolev/tmuxline ----
"
"\'a'               : '#{?client_prefix,#[reverse][P]#[noreverse] ,}#{?window_zoomed_flag,#[reverse][F]#[noreverse] ,}#S',
" show [P] when prefix active, [F] when zoomed
let g:tmuxline_preset = {
      \'a'               : '#S',
      \'win'             : ['#I', '#W'],
      \'cwin'            : ['#I', '#W#{?window_zoomed_flag, *Z,}'],
      \'x'               : '#(focus)',
      \'y'               : ['%a, %b %d'],
      \'z'               : '%R #(bat)',
      \'options'         : {
        \'status-justify'  : 'left'}
      \}
" simple
let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '|',
    \ 'right' : '',
    \ 'right_alt' : '|',
    \ 'space' : ' '}

" -----------------------------------------------------------------------------


" Plugin: majutsushi/tagbar ----
"
" Open/close tagbar with <space>g
nmap <silent> <leader>g :TagbarToggle<CR>

" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)
" -----------------------------------------------------------------------------

" Plugin: w0rp/ale ----
"
let g:ale_linters = {
\   'php': ['php -l', 'phpcs', 'phpmd', 'phpstan'],
\}
let g:ale_php_phpcs_standard='~/.config/code-rules/phpcs.xml'
let g:ale_php_phpmd_ruleset='~/.config/code-rules/phpmd.xml'
let g:ale_set_loclist=1
let g:ale_lint_delay = 1000
" -----------------------------------------------------------------------------

" Plugin: junegunn/vim-slash ----
"
if has('timers') && !has('nvim')
   noremap <expr> <plug>(slash-after) slash#blink(2, 50)
 endif
" -----------------------------------------------------------------------------

" Plugin: morhetz/gruvbox ----
"
" let g:gruvbox_contrast_dark = 'soft'
" -----------------------------------------------------------------------------

" Plugin: justinmk/vim-sneak ----
"
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
" let g:sneak#absolute_dir = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
let g:sneak#target_labels = ";sftunqwgjhmblkyd/SFGHLTUNRMQZ?0123456789"
" -----------------------------------------------------------------------------

"******************************************************************************
" Setting: UI
"******************************************************************************

" UI: color scheme
"
set background=dark
" colorscheme Tomorrow-Night " dark
" colorscheme solarized " dark
" colorscheme OceanicNext " dark
colorscheme gruvbox

" -----------------------------------------------------------------------------
" %< Where to truncate
" %n buffer number
" %F Full path
" %m Modified flag: [+], [-]
" %r Readonly flag: [RO]
" %y Type:          [vim]
" fugitive#statusline()
" %= Separator
" %-14.(...)
" %l Line
" %c Column
" %V Virtual column
" %P Percentage
" %#HighlightGroup#
set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P


