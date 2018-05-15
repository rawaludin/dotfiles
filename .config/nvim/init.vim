" vim: set foldmethod=marker foldlevel=0 nomodeline:
"
" nvim configuration
"
" Load Plugin {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" ----- Making Vim look good ------------------------------------------
" This one will work with neovim
Plug 'edkolev/tmuxline.vim'
Plug 'morhetz/gruvbox'
Plug 'icymind/NeoSolarized'
Plug 'arcticicestudio/nord-vim'
" those colors work well with f.lux
Plug 'jonathanfilip/vim-lucius'
Plug 'robertmeta/nofrils'
Plug 'ap/vim-buftabline'

" ----- Vim as a programmer's text editor -----------------------------
Plug 'jiangmiao/auto-pairs' " Insert or delete brackets, parens, quotes in pair
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] } " faster align
Plug 'junegunn/vim-slash' " Enhancing in-buffer search experience
Plug 'justinmk/vim-sneak' " Jump to any location specified by two character
Plug 'kylef/apiblueprint.vim' " syntax highlight for API Blueprint doc
Plug 'mattn/emmet-vim' " faster html tag generation
Plug 'qpkorr/vim-bufkill' " Delete buffer without closing split :BD :BW :BUN
Plug 'terryma/vim-multiple-cursors'
Plug 'tmux-plugins/vim-tmux-focus-events' " make FocusGained and FocusLost work again in Tmux, this event used for autosave
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary' " comment by gc
Plug 'tpope/vim-eunuch' " Vim sugar for the UNIX shell commands
Plug 'tpope/vim-repeat' " Make repeat work on plugin custom command
Plug 'tpope/vim-surround' " faster surround
Plug 'vimwiki/vimwiki' " personal note taker
Plug 'w0rp/ale' " linter
" Disable netrw, let's try dirvish
Plug 'justinmk/vim-dirvish'
let g:loaded_netrwPlugin = 0
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" ----- Working with PHP ----------------------------------------------
Plug 'arnaud-lb/vim-php-namespace' " insert php `use` statement automatically  by <Leader>u in normal mode
" ----- autocompletion ----
" manual trigger complete with ^x^o (omnifunc)
" run :LanguageClientStart / Stop to index project
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install -vvv && composer run-script parse-stubs'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " need pip3 install neovim

" ----- Working with Git ----------------------------------------------
Plug 'airblade/vim-gitgutter' " display each line git status
Plug 'tpope/vim-fugitive' " git inside vim
Plug 'tpope/vim-rhubarb' " github extension for fugitive

" ----- Other text editing features -----------------------------------
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
set colorcolumn=81,121 " column guide at 81 and 121 char
set number relativenumber " for easier execute macro
" support true color (enable this when tmux support true color)
if (has('termguicolors'))
  let &t_8f = '\<Esc>[38;2;%lu;%lu;%lum'
  let &t_8b = '\<Esc>[48;2;%lu;%lu;%lum'
  set termguicolors
endif

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '' : printf(
    \   ' [%dW %dE]',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

" return '[&et]' if &et is set wrong
" return '[mixed-indenting]' if spaces and tabs are used to indent
" return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

" recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

" return '[\s]' if trailing white space is detected
" return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? '('.fugitive#head().')' : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P '
  let ale = '%{LinterStatus()}'
  let whitespace_tab_warning = '%{StatuslineTabWarning()}'
  let whitespace_trailing = '%{StatuslineTrailingSpaceWarning()}'

  return '%F %<'.mod.ro.ft.fug.ale.whitespace_tab_warning.whitespace_trailing.sep.pos.'%*'.pct
endfunction
let &statusline = s:statusline_expr()

" day
set background=dark
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
" }}}

" Mapping {{{

" Set leader key to space
let mapleader = " "
" edit vimrc file by <space>v
nmap <leader>v :edit $MYVIMRC<CR>
" exit terminal mode
tnoremap <C-a> <C-\><C-n>

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
nnoremap <leader>l :diffupdate<cr>:syntax sync fromstart<cr>:Strip<cr>:w<cr>

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

augroup filetype_php
  " formatter, folding, reindex ctags
  autocmd FileType php noremap <leader>wf :!php-cs-fixer fix "%" --rules=@PSR1,@PSR2,no_unused_imports<cr><cr>
  autocmd FileType php set foldmethod=indent foldlevel=20
  autocmd BufWritePost *.php :call jobstart('[ ! -f tags.lock ] && touch tags.lock && ctags -R --languages=php --php-kinds=cfit && rm -rf tags.lock')
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
" close all buffer <space>D
map <silent> <leader>D :bufdo bd<CR>
" close all buffer except active buffer
function! CloseAllBuffersButCurrent()
  let curr = bufnr("%")
  let last = bufnr("$")
  if curr > 1    | silent! execute "1,".(curr-1)."bd"     | endif
  if curr < last | silent! execute (curr+1).",".last."bd" | endif
endfunction
command! BO :call CloseAllBuffersButCurrent()<CR>
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
command! Strip call <SID>StripTrailingWhitespaces()

" vim-multiple-cursor {{{
" When press ESC from insert mode on multiple cursor, back to multiple cursor,
" not regular vim
let g:multi_cursor_exit_from_insert_mode = 0
" }}}

" vim-easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" fzf {{{
" fuzzy open file in current project with <space>p
nmap <silent> <leader>p :Files<CR>
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
" }}}

" emmet-vim {{{
" Auto complete by c-y, (control y comma)
let g:user_emmet_install_global = 0
autocmd FileType html,css,php,js,jsx EmmetInstall
" }}}

" vim-php-namespace {{{
" Press `<space>u` while on the class being used in normal mode to insert `use`
" statement
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
" Press `<space>e` to expand to fully quailified class name
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>
" }}}

" tmuxline {{{
let g:tmuxline_preset = {
      \'a'               : '#S',
      \'win'             : ['#W'],
      \'cwin'            : ['#W#{?window_zoomed_flag, *Z,}'],
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
" }}}

" tagbar {{{
" Open/close tagbar with <space>g
nmap <silent> <leader>g :TagbarToggle<CR>

" ale {{{
let g:ale_linters = {
\   'php': ['php', 'phpcs', 'phpmd'],
\}
let g:ale_php_phpcs_standard='~/.config/code-rules/phpcs.xml'
let g:ale_php_phpmd_ruleset='~/.config/code-rules/phpmd.xml'
let g:ale_set_loclist=1
let g:ale_lint_delay = 1000
nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)
" }}}

" vim-sneak {{{
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
" let g:sneak#absolute_dir = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
let g:sneak#target_labels = ";sftunqwgjhmblkyd/SFGHLTUNRMQZ?0123456789"
" }}}

" neosnippet {{{
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'
let g:neosnippet#disable_runtime_snippets = {
\   '_' : 1,
\ }
imap <c-k> <Plug>(neosnippet_expand_or_jump)
smap <c-k> <Plug>(neosnippet_expand_or_jump)
xmap <c-k> <Plug>(neosnippet_expand_target)
let g:neosnippet#enable_completed_snippet=1
" }}}

" {{{ vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
" }}}

" {{{ deoplete
let g:deoplete#enable_at_startup = 1
" }}}
