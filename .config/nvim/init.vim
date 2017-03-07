
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
if has('nvim')
  Plug 'frankier/neovim-colors-solarized-truecolor-only'
endif
" Plug 'mhartington/oceanic-next'
" Plug 'trevordmiller/nova-vim'

" ----- Vim as a programmer's text editor -----------------------------
" Plug 'chrisbra/Recover.vim' " Diff on recovery from swap file
Plug 'diepm/vim-rest-console' " Similiar to Postman in vim
Plug 'jiangmiao/auto-pairs' " Insert or delete brackets, parens, quotes in pair
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] } " faster align
Plug 'mattn/emmet-vim' " faster html tag generation
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle'   } " Display undotree
Plug 'qpkorr/vim-bufkill' " Delete buffer without closing split :BD :BW :BUN
Plug 'scrooloose/nerdtree' " tree view of current project
Plug 'sheerun/vim-polyglot' " Language packs collection, won't affect startup time
Plug 'terryma/vim-multiple-cursors'
Plug 'thinca/vim-quickrun', { 'on' : 'QuickRun'} " Quick run current buffer in specified runner
Plug 'tmux-plugins/vim-tmux-focus-events' " make FocusGained and FocusLost work again in Tmux, this event used for autosave
Plug 'tpope/vim-unimpaired' " faster movement quicklist, loclist, etc with [  ]
Plug 'tpope/vim-commentary' " comment by gc
Plug 'tpope/vim-repeat' " Make repeat work on plugin custom command
Plug 'tpope/vim-surround' " faster surround
Plug 'tpope/vim-eunuch' " Vim sugar for the UNIX shell commands 
Plug 'tpope/vim-abolish' " easily search for, substitute, and abbreviate multiple variants of a word
Plug 'vim-scripts/BufOnly.vim' " used to close other buffer except the active one with :BufOnly
Plug 'vimwiki/vimwiki' " activate wiki with <leader>ww
" Plug 'yuttie/comfortable-motion.vim' " inertia scrooling
Plug 'w0rp/ale' " asynchronous lint engine
Plug 'justinmk/vim-sneak' " Jump to any location specified by two character

" ----- Working with PHP ----------------------------------------------
Plug 'arnaud-lb/vim-php-namespace' " insert php `use` statement automatically  by <Leader>u in normal mode
Plug 'ludovicchabant/vim-gutentags' " Automatic tag generation when file saved / modified
" Plug 'shawncplus/phpcomplete.vim' " improve php omnicompletion


" ----- Working with Clojure ------------------------------------------
" Plug 'tpope/vim-fireplace' " Connect to REPL

" ----- Working with Git ----------------------------------------------
Plug 'airblade/vim-gitgutter' " display each line git status
Plug 'tpope/vim-fugitive' " git inside vim
Plug 'lambdalisue/gina.vim', {'on': ['Gina']} " Asynchronously control git repositories in Neovim/Vim 8
" ----- Working with Markdown ----------------------------------------------
Plug 'plasticboy/vim-markdown' | Plug  'godlygeek/tabular', { 'for': 'markdown' } " better markdown highlight
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " no distraction mode
" Plug 'reedes/vim-colors-pencil' " ia writer inspired theme, good for writing

" ----- Other text editing features -----------------------------------

"  text snippet
" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'tomtom/tlib_vim' 
" Plug 'MarcWeber/vim-addon-mw-utils' 
" Plug 'garbas/vim-snipmate' 

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Autocomplete. this one support neovim natively
endif
" Auto generate ctags
" Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] } " faster align
Plug 'xolox/vim-misc', { 'on': ['UpdateTags'] }
Plug 'xolox/vim-easytags', { 'on': ['UpdateTags'] }
Plug 'majutsushi/tagbar' " view ctags on sidebar

" ----- Vim for Go Developer -------------------------------------------
"  Loaded when opening Go files
" Plug 'fatih/vim-go', {'for': 'go'}

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

" disable menus to save 50ms startup time
let did_install_default_menus = 1
let did_install_syntax_menu = 1

" Enable mouse only in normal mode. So my cursor don't accidentally moved when
" my palm touch trackpad
set mouse=n

" Use project based tags beside global tags on ~/.vimtags / ~/tags
" check current tags file in use with `:set tags?`
set tags=tags;

" support true color (enable this when tmux support true color)
if (has("termguicolors"))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" different cursor on insert and normal mode (only work for iTerm2)
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" exit insert when pressing up/down in insert mode
inoremap <silent> <Up> <ESC><Up>
inoremap <silent> <Down> <ESC><Down>

" exit insert when scroll up/down in insert mode
inoremap <silent> <ScrollWheelUp> <ESC><ScrollWheelUp>
inoremap <silent> <ScrollWheelDown> <ESC><ScrollWheelDown>

" qq to record macor, Q to replay
nmap Q @q

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


" Plugin: junegunn/goyo ----
"
" activate goyo when opening markdown
" au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} Goyo
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown " set syntax as markdown when opening md
" -----------------------------------------------------------------------------

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


" Plugin: diepm/vim-rest-console ----
"
" Allow request body in get (will result in XGET in curl)
let g:vrc_allow_get_request_body = 1
" -----------------------------------------------------------------------------


" Plugin: vim-airline/vim-airline ----
"
" set theme
" solarized, distinguished, tomorrow, powerlineish, papercolor, raven, silver, ubaryd, zenburn, oceanixtnext
let g:airline_theme = 'simple'
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
" let g:airline_skip_empty_sections = 1
" simple, without powerline
let g:airline_left_sep=''
let g:airline_left_alt_sep='|'
let g:airline_right_sep=''
let g:airline_right_alt_sep='|'
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
nmap <silent> <leader>p :FZF<CR>
" List recent opened file <space>h
nmap <silent> <leader>h :History<CR>
" Jump to opened file (buffer) with <space><Enter>
nnoremap <silent> <leader><Enter> :Buffers<CR>
" Jump to method or variable/attribute in current file <space>r
nmap <silent> <leader>r :BTags<CR>
" Jumt to lines in current buffer and search for string <space>/
nmap <silent> <leader>/ :BLines<CR>
" Change binding for split
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R --language=php --php-kinds=cfit'
" -----------------------------------------------------------------------------


" Plugin: airblade/vim-gitgutter  ----
"
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1
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


" Plugin: xolox/vim-easytags ----
"
" use project local tags ./tags (see up) and auto create it
let g:easytags_dynamic_files = 2
" Generate tags only when files is saved
let g:easytags_events = []
" asynchronous tag generate
let g:easytags_async = 1
" resolve symbolic links in pathname (useful for unix)
let g:easytags_resolve_links = 1
" suppress the warning on startup if ctags is not found or not recent enough
" let g:easytags_suppress_ctags_warning = 1
" faster syntax highlighting using pyhon
" let g:easytags_python_enabled = 1
" use old regex engine to make it faster
" https://github.com/xolox/vim-easytags/issues/88#issuecomment-69474765
set regexpengine=1
" disable auto highlight
let g:easytags_auto_highlight = 0
" always sacrifice accuracy to improve performance
" let g:easytags_syntax_keyword = 'always'
" -----------------------------------------------------------------------------


" Plugin: mattn/emmet-vim ----
"
let g:user_emmet_install_global = 0
autocmd FileType html,css,php EmmetInstall
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

" Plugin: craigemery/vim-autotag ----
"
" -----------------------------------------------------------------------------

" Plugin: StanAngeloff/php.vim ----
"
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END
" -----------------------------------------------------------------------------


" Plugin: fatih/vim-go ----
"
" format with goimports and gofmt when saving go file
let g:go_fmt_command = "goimports"
" -----------------------------------------------------------------------------


" Plugin: edkolev/tmuxline ----
"
" show [P] when prefix active, [F] when zoomed
let g:tmuxline_preset = {
      \'a'               : '#{?client_prefix,#[reverse][P]#[noreverse] ,}#{?window_zoomed_flag,#[reverse][F]#[noreverse] ,}#S',
      \'win'             : ['#I', '#W'],
      \'cwin'            : ['#I', '#W'],
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
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)
" -----------------------------------------------------------------------------


" Plugin: justinmk/vim-sneak ----
"
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
" let g:sneak#absolute_dir = 1
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_Tk
let g:sneak#target_labels = ";sftunqwgjhmblkyd/SFGHLTUNRMQZ?0123456789"
" -----------------------------------------------------------------------------

"******************************************************************************
" Setting: UI
"******************************************************************************

" UI: color scheme
"
set background=dark
" colorscheme Tomorrow-Night " dark
colorscheme solarized " dark
" colorscheme OceanicNext " dark

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

