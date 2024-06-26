" vim: set foldmethod=marker foldlevel=0 nomodeline:
"
" nvim configuration
" Rahmat Awaludin <rahmat.awaludin@gmail.com>
"
" Auto install plugin {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup InstallPlugin
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

call plug#begin('~/.config/nvim/plugged')

" ----- Making Vim look good ------------------------------------------
Plug 'edkolev/tmuxline.vim'
" Tmuxline {{{
let g:tmuxline_preset = {
      \'a'               : '#S',
      \'win'             : ['#W'],
      \'cwin'            : ['#W#{?window_zoomed_flag, *Z,}'],
      \'y'               : ['%a, %b %d'],
      \'z'               : '%R#(battery-info)',
      \'options'         : {
        \'status-justify'  : 'left'}
      \}
Plug 'oxfist/night-owl.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1

" ----- Vim as a programmer's text editor -----------------------------
Plug 'jiangmiao/auto-pairs' " Insert or delete brackets, parens, quotes in pair
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] } " faster align
Plug 'junegunn/vim-slash' " Enhancing in-buffer search experience
Plug 'justinmk/vim-sneak' " Jump to any location specified by two character
Plug 'justinmk/vim-dirvish' " Disable netrw, use dirvish instead
Plug 'mattn/emmet-vim' " faster html tag generation
Plug 'petertriho/nvim-scrollbar'
" Emmet {{{
" Auto complete by c-y, (control y comma)
" let g:user_emmet_install_global = 0
" augroup InstallEmmet
"   autocmd FileType html,css,php,js,jsx EmmetInstall
" augroup END
" }}}
Plug 'ap/vim-css-color'
" make FocusGained and FocusLost work again in Tmux, this event used for autosave
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-commentary' " comment by gc
Plug 'tpope/vim-eunuch' " Vim sugar for the UNIX shell commands
Plug 'tpope/vim-repeat' " Make repeat work on plugin custom command
Plug 'tpope/vim-surround' " faster surround
Plug 'tpope/vim-abolish' " coercion (snake_case to camelCaset, etc) & replace word variant
Plug 'AndrewRadev/splitjoin.vim' " split to multiline with gS join multiline with gJ

" ----- Working with JS -------------------------------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
let g:coc_global_extensions = [
  \ 'coc-eslint',
  \ 'coc-fzf-preview',
  \ 'coc-html',
  \ 'coc-html-css-support',
  \ 'coc-htmlhint',
  \ 'coc-json',
  \ 'coc-php-cs-fixer',
  \ 'coc-phpls',
  \ 'coc-prettier',
  \ 'coc-sh',
  \ 'coc-sql',
  \ 'coc-svg',
  \ 'coc-tsserver',
  \ 'coc-vimlsp'
  \ ]

" ----- Working with PHP ----------------------------------------------
Plug 'arnaud-lb/vim-php-namespace'
let g:php_namespace_sort_after_insert = 1
augroup PhpUseStatement
  " Press `<space>u` while on the class being used in normal mode to insert `use` statement
  autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
  " Press `<space>e` to expand to fully quailified class name
  autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>
  " put end semicolon
  autocmd FileType php inoremap <c-e> <esc>A;<esc>
  autocmd FileType php noremap <c-e> A;<esc>
augroup END

" ----- Working with Git ----------------------------------------------
Plug 'mhinz/vim-signify'
let g:signify_vcs_list = ['git']
let g:signify_sign_add          = '│'
let g:signify_sign_change       = '│'
let g:signify_sign_changedelete = '│'
Plug 'tpope/vim-fugitive' " git inside vim
Plug 'tpope/vim-rhubarb' " github extension for fugitive

" ----- Other text editing features -----------------------------------
Plug 'majutsushi/tagbar' " view ctags on sidebar

Plug 'ryanoasis/vim-devicons'
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
set tags=tags " only use tags file on root
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

" Autocommand {{{
augroup AutoWriteOnLostFocus
  autocmd FocusLost * silent! wa " autosave when focus is lost, not save unsaved buffer
augroup END

augroup AutoSpellCheckForGitCommitMessage
  autocmd FileType gitcommit setlocal spell
augroup END

augroup NumberToggle
  " Relative line number on active buffer, absolute line number on inactive bufferr
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

augroup VimrcSyncFromstart
  " The PC is fast enough, do syntax highlight syncing from start
  autocmd BufEnter * :syntax sync fromstart
  autocmd BufLeave * :syntax sync clear
augroup END

augroup VimrcRememberCursorPosition
  " Remember cursor position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
" }}}

" Mapping {{{

" Set leader key to space
let g:mapleader = ' '
" edit vimrc file by <space>v
nnoremap <leader>v :edit $MYVIMRC<CR>
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
nnoremap Q @q
" redraw syntax by <space>l
nnoremap <leader>l :diffupdate<cr>:syntax sync fromstart<cr>:Strip<cr>:w<cr>
" select last pasted block by gp, use native gv for last selected text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" Use arrow to resize pane
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>
" make c-n and c-p mimic up and down behaviour on command mode
cnoremap <c-n> <down>
cnoremap <c-p> <up>
" double click jump to tag
nnoremap <2-LeftMouse> <c-]>
" More text-object
for g:char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`' ]
    execute 'xnoremap i' . g:char . ' :<C-u>normal! T' . g:char . 'vt' . g:char . '<CR>'
    execute 'onoremap i' . g:char . ' :normal vi' . g:char . '<CR>'
    execute 'xnoremap a' . g:char . ' :<C-u>normal! F' . g:char . 'vf' . g:char . '<CR>'
    execute 'onoremap a' . g:char . ' :normal va' . g:char . '<CR>'
endfor

augroup filetype_php
  " formatter, folding, reindex ctags
  autocmd FileType php set foldmethod=indent foldlevel=20
  " Regenerate ctags
  " - when tags.lock is older than 2 min, start fresh
  " - regenerate only if tags.lock not exist
  " - when starting job to regenerate, create tags.lock file
  let generate_ctags = 'find . -name tags.lock -mmin +2 -exec rm {} tags \;
        \ && [ ! -f tags.lock ] && touch tags.lock
        \ && ctags -R --languages=php --php-kinds=cfit
        \ && rm -rf tags.lock'
  autocmd BufWritePost *.php :call jobstart(generate_ctags)
augroup END
" open tag in vertical split
map <C-s><C-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" }}}

" Buffer & Tab Management {{{
" Copy current buffer path relative to root of VIM session to system clipboard
nnoremap <Leader>yp :let @*=expand("%")<cr>:echo "Copied file path to clipboard"<cr>
" Copy current filename to system clipboard
nnoremap <Leader>yf :let @*=expand("%:t")<cr>:echo "Copied file name to clipboard"<cr>
" Copy current buffer path without filename to system clipboard
nnoremap <Leader>yd :let @*=expand("%:h")<cr>:echo "Copied file directory to clipboard"<cr>
" Copy current method name to system clipboard
nnoremap <Leader>ym :CopyPhpMethodName<cr>
function! <SID>CopyPhpMethodName()
  " Preparation: save last cursor position.
  let l:l = line('.')
  let l:c = col('.')
  " Do the business:
  normal [[ww"*yiw
  " Clean up: restore previous cursor position
  call cursor(l:l, l:c)
  echo "Copied method to clipboard"
endfunction
command! CopyPhpMethodName call <SID>CopyPhpMethodName()

" undo close buffer by <Ctrl><shift>t
nnoremap <silent> <C-T> :e #<CR>
" new empty buffer by space+n (useful for tinkering script)
nnoremap <silent> <leader>n :enew<cr>
" jump to buffer mapping
nnoremap <silent> [w :bprevious<CR>
nnoremap <silent> ]w :bnext<CR>
nnoremap <silent> {w :bfirst<CR>
nnoremap <silent> }w :blast<CR>
" jump to tab mapping
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> {t :tabfirst<CR>
nnoremap <silent> }t :tablast<CR>
" jump to quickfix mapping
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
" jump to location-list mapping
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]l :lnext<CR>
" toggle background
" @todo should toggle tmuxline as well, update config too
nnoremap <silent> yob :set background=<C-R>=&background == "dark" ? "light" : "dark"<CR><CR>
" delete buffer <space>d
nnoremap <silent> <leader>d :bd<cr>
" close all buffer <space>D
nnoremap <silent> <leader>D :bufdo bd<CR>
" close all buffer except active buffer
function! CloseAllBuffersButCurrent()
  let l:curr = bufnr('%')
  let l:last = bufnr('$')
  if l:curr > 1 | silent! execute '1,'.(l:curr-1).'bd' | endif
  if l:curr < l:last | silent! execute (l:curr+1).','.l:last.'bd' | endif
endfunction
command! BO :call CloseAllBuffersButCurrent()
" Switch between two buffer back and forth by <space>q
nnoremap <leader>q :b#<cr>
" jump to last tab <space>Tab
let g:lasttab = 1
nnoremap <Leader><Tab> :exe "tabn ".g:lasttab<CR>
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
" }}}

" fuzzy open file in current project with <space>p
nnoremap <silent> <leader>p :Files<CR>
" List recent opened file <space>h
nnoremap <silent> <leader>h :History:<CR>
" Jump to opened file (buffer) with <space><Enter>
nnoremap <silent> <leader><Enter> :Buffers<CR>
" Jump to method or variable/attribute in current file <space>r
nnoremap <silent> <leader>r :BTags<CR>
" nmap <silent> <leader>r :call LanguageClient#textDocument_documentSymbol()<CR>
" Jumt to lines in current buffer and search for string <space>/
nnoremap <silent> <leader>/ :BLines<CR>
" Change binding for split
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R --language=php --php-kinds=cfit'
let $FZF_DEFAULT_OPTS .= ' --layout=reverse'
" }}}

" EasyAlign {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" Sneak {{{
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
let g:sneak#target_labels = ';sftunqwgjhmblkyd/SFGHLTUNRMQZ?0123456789'
" }}}

" dirvish {{{
let g:loaded_netrwPlugin = 0
let g:dirvish_mode = ':sort ,^.*[\/],'
command! -nargs=? -complete=dir Explore | exe 'silent Dirvish '.(empty('<args>')?'%':'<args>')
command! -nargs=? -complete=dir Sexplore belowright split | exe 'silent Dirvish '.(empty('<args>')?'%':'<args>')
command! -nargs=? -complete=dir Vexplore leftabove vsplit | exe 'silent Dirvish '.(empty('<args>')?'%':'<args>')
" }}}

" Tagbar {{{
" Open/close tagbar with <space>g
nmap <silent> <leader>g :TagbarToggle<CR>
" }}}

" COC {{{
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.
" }}}

" lua << EOF
"
" EOF

lua require("scrollbar").setup()

set background=dark
colorscheme night-owl
let g:airline_theme='night_owl'
