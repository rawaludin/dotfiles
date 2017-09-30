" vim: set foldmethod=marker foldlevel=0 nomodeline:
"
" nvim configuration
"
" Load Plugin {{{
call plug#begin('~/.config/nvim/plugged')

" ----- Making Vim look good ------------------------------------------
" This one will work with neovim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'edkolev/tmuxline.vim' " theme has been generated. No need to sync now.
" Plug 'mhartington/oceanic-next'
" Plug 'lifepillar/vim-solarized8'
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
Plug 'vim-scripts/BufOnly.vim' " used to close other buffer except the active one with :BufOnly
Plug 'justinmk/vim-sneak' " Jump to any location specified by two character
Plug 'gorkunov/smartpairs.vim' " easy expand selection

" ----- Working with PHP ----------------------------------------------
Plug 'arnaud-lb/vim-php-namespace' " insert php `use` statement automatically  by <Leader>u in normal mode
" Plug 'ludovicchabant/vim-gutentags' " Automatic tag generation when file saved / modified
" Plug 'joonty/vdebug'
" Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }

" ----- Working with Git ----------------------------------------------
Plug 'airblade/vim-gitgutter' " display each line git status
Plug 'tpope/vim-fugitive' " git inside vim
Plug 'tpope/vim-rhubarb' " github extension for fugitive

" ----- Working with Markdown ----------------------------------------------
" Plug 'plasticboy/vim-markdown' | Plug  'godlygeek/tabular', { 'for': 'markdown' } " better markdown highlight

" ----- Other text editing features -----------------------------------
Plug 'w0rp/ale' " linter
Plug 'SirVer/ultisnips' " text snippet
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Autocomplete. this one support neovim natively
" endif
Plug 'kylef/apiblueprint.vim' " syntax highlight for API Blueprint doc
" Plug 'vimwiki/vimwiki' " personal note taker

" Auto generate ctags
Plug 'majutsushi/tagbar' " view ctags on sidebar

call plug#end()
" }}}

" General {{{
set autoread " detect latest change outside vim
set autowriteall " save buffer when switch to other buffer
set clipboard+=unnamedplus " share clipboard with OSX
set expandtab " Expand tabs into spaces
set hidden " hide error when opening file but current buffer has unsaved changes
set ignorecase " ignore case on autocomplete command
set inccommand=split " live replace feedback in neovim :%s/foo/bar<CR>
set lazyredraw " for faster scrolling
set mouse=n " Enable mouse only in normal mode. So my cursor don't accidentally moved when my palm touch trackpad
set shiftwidth=2 " for when <TAB> is pressed at the beginning of a line
set smartcase " If there uppercase in search term, case sensitive again
set softtabstop=2 " default to 2 spaces for the soft tab
set tabstop=2 " default to 2 spaces for a hard tab
set visualbell " disable bell / beep
set wrap linebreak nolist " better word wrap
" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.
set undodir=/tmp//,.
" use rg for grep
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
let g:did_install_default_menus = 1
let g:did_install_syntax_menu = 1 " save 50ms startup time
" }}}

" UI {{{
set background=dark
set colorcolumn=81,121 " column guide at 81 and 121 char
set number relativenumber " for easier execute macro
" support true color (enable this when tmux support true color)
if (has('termguicolors'))
  let &t_8f = '\<Esc>[38;2;%lu;%lu;%lum'
  let &t_8b = '\<Esc>[48;2;%lu;%lu;%lum'
  set termguicolors
endif
colorscheme gruvbox
" }}}

" Autocommand {{{
augroup AutoWriteOnLostFocus
  autocmd FocusLost * silent! wa " autosave when focus is lost, not save unsaved buffer
augroup END

augroup NumberToggle
  " Relative line number on active buffer, absolute line number on inactive bufferr
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

augroup VimrcSyncFromstart
  " The PC is fast enough, do syntax highlight syncing from start
  autocmd BufEnter * :syntax sync fromstart
augroup END

augroup VimrcRememberCursorPosition
  " Remember cursor position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

function! SnipperSetCursor()
  set cursorline
  set cursorcolumn
endfunction
function! SnipperUnSetCursor()
  set nocursorline
  set nocursorcolumn
endfunction

augroup SnipperCursor
  au! CursorHold * call SnipperUnSetCursor()
  au! CursorMoved * call SnipperSetCursor()
  au! CursorMovedI * call SnipperUnSetCursor()
augroup END
" }}}

" Mapping {{{

" Set leader key to space
let mapleader = " "
" edit vimrc file by <space>v
nmap <leader>v :edit $MYVIMRC<CR>

" make . work with visually selected lines
vnoremap . :norm.<CR>

" exit insert when pressing up/down in insert mode
inoremap <silent> <Up> <ESC><Up>
inoremap <silent> <Down> <ESC><Down>

" exit insert when scroll up/down in insert mode
inoremap <silent> <ScrollWheelUp> <ESC><ScrollWheelUp>
inoremap <silent> <ScrollWheelDown> <ESC><ScrollWheelDown>

" qq to record macor, Q to replay
nmap Q @q

" redraw syntax by <space>l
nnoremap <leader>l :diffupdate<cr>:syntax sync fromstart<cr>:Strip<cr>:w<cr><c-l>

" select last pasted block by gp
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Use arrow to resize pane
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>

" make c-n and c-p mimic up and down behaviour on command mode
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" More text-object
for g:char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`' ]
    execute 'xnoremap i' . g:char . ' :<C-u>normal! T' . g:char . 'vt' . g:char . '<CR>'
    execute 'onoremap i' . g:char . ' :normal vi' . g:char . '<CR>'
    execute 'xnoremap a' . g:char . ' :<C-u>normal! F' . g:char . 'vf' . g:char . '<CR>'
    execute 'onoremap a' . g:char . ' :normal va' . g:char . '<CR>'
endfor

augroup PhpFormatter
  " Simple php formatter using php-cs-fixer
  autocmd FileType php noremap <leader>wf :!php-cs-fixer fix "%" <cr><cr>
augroup END
" }}}

" Buffer & Tab Management {{{
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
augroup SetLastTab
  autocmd TabLeave * let g:lasttab = tabpagenr()
augroup END
" }}}

" Functions {{{
"
" Delete all trailing whitespace in current buffer by :Strip
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let l:_s=@/
    let l:l = line('.')
    let l:c = col('.')
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=l:_s
    call cursor(l:l, l:c)
endfunction
command! Strip call <SID>StripTrailingWhitespaces()<CR>
" }}}

" Plugin Settings {{{
" 
" =============================================================================
" vim-multiple-cursor
" =============================================================================
" When press ESC from insert mode on multiple cursor, back to multiple cursor,
" not regular vim
let g:multi_cursor_exit_from_insert_mode = 0


" =============================================================================
" vim-easy-align
" =============================================================================
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" =============================================================================
" vim-airline
" =============================================================================
" set theme
let g:airline_theme = 'gruvbox'
" Always show statusbar
set laststatus=2
" Fancy arrow symbols, requires a patched font https://github.com/abertsch/Menlo-for-Powerline
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

" =============================================================================
" Nerdtree
" =============================================================================
" Open/close NERDTree Tabs with <space>t
" nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
nmap <silent> <leader>t :NERDTreeToggle<CR>
" Open synced tree with <space>st
map <silent> <leader>st :NERDTreeFind<CR>
" To have NERDTree always open on startup set this to 2
let g:nerdtree_tabs_open_on_console_startup = 0

" =============================================================================
" fzf
" =============================================================================
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

" =============================================================================
" vim-gitgutter
" =============================================================================
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1

" =============================================================================
" vim-markdown 
" =============================================================================
let g:vim_markdown_folding_disabled=1 " disable folding because performance,
                " see https://github.com/plasticboy/vim-markdown/issues/162
" disable indent when new paragraph with `o` from list
au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} setlocal indentexpr=''
" Close TOC after click enter on heading link
nnoremap <expr><enter> &ft=="qf" ? "<cr>:lcl<cr>" : (getpos(".")[2]==1 ? "i<cr><esc>": "i<cr><esc>l")

" =============================================================================
" emmet-vim
" =============================================================================
let g:user_emmet_install_global = 0
autocmd FileType html,css,php,js,jsx EmmetInstall
let g:user_emmet_leader_key='<Tab>'  " autocomplete emmet by <Tab><comma>

" =============================================================================
" deoplete.nvim
" =============================================================================
" Always enable (to manual enable :DeopleteEnable / :DeopleteDisable)
" Make sure you have setup ctags for this to work
let g:deoplete#enable_at_startup = 1
" use phpcd for php completion
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
let g:deoplete#ignore_sources.php = ['omni']

" =============================================================================
" vim-php-namespace
" =============================================================================
" Press `<space>u` while on the class being used in normal mode to insert `use`
" statement
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
" Press `<space>e` to expand to fully quailified class name
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>

" =============================================================================
" tmuxline
" =============================================================================
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

" =============================================================================
" tagbar
" =============================================================================
" Open/close tagbar with <space>g
nmap <silent> <leader>g :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)

" =============================================================================
" ale
" =============================================================================
let g:ale_linters = {
\   'php': ['php -l', 'phpcs', 'phpmd'],
\}
let g:ale_php_phpcs_standard='~/.config/code-rules/phpcs.xml'
let g:ale_php_phpmd_ruleset='~/.config/code-rules/phpmd.xml'
let g:ale_set_loclist=1
let g:ale_lint_delay = 1000

" =============================================================================
" vim-sneak
" =============================================================================
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
" let g:sneak#absolute_dir = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
let g:sneak#target_labels = ";sftunqwgjhmblkyd/SFGHLTUNRMQZ?0123456789"
" }}}
