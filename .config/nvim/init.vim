" vim: set foldmethod=marker foldlevel=0 nomodeline:
"
" nvim configuration
" Rahmat Awaludin <rahmat.awaludin@gmail.com>
"
" Install plugin {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup InstallPlugin
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

call plug#begin('~/.config/nvim/plugged')

" ----- Making Vim look good ------------------------------------------
" Plug 'edkolev/tmuxline.vim'
" Tmuxline config {{{
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
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark='hard'
Plug 'vim-airline/vim-airline'
Plug 'kyazdani42/nvim-web-devicons'

" ----- Vim as a programmer's text editor -----------------------------
Plug 'jiangmiao/auto-pairs' " Insert or delete brackets, parens, quotes in pair
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] } " faster align
Plug 'junegunn/vim-slash' " Enhancing in-buffer search experience
Plug 'justinmk/vim-sneak' " Jump to any location specified by two character s<char><char>
Plug 'justinmk/vim-dirvish' " Disable netrw, use dirvish instead
Plug 'tpope/vim-commentary' " comment by gcc
Plug 'tpope/vim-eunuch' " Vim sugar for the UNIX shell commands
Plug 'tpope/vim-repeat' " Make repeat work on plugin custom command
Plug 'tpope/vim-surround' " faster surround
Plug 'tpope/vim-abolish' " coercion (snake_case to camelCaset, etc) & replace word variant
Plug 'vimwiki/vimwiki' " personal note taker
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
Plug 'w0rp/ale' " linter
Plug 'AndrewRadev/splitjoin.vim' " split to multiline with gS join multiline with gJ
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hrsh7th/nvim-compe'

" ----- Working with PHP ----------------------------------------------
Plug 'arnaud-lb/vim-php-namespace'

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
nmap <silent> <leader>g :TagbarToggle<CR>
Plug 'ludovicchabant/vim-gutentags'
if executable('rg')
  let g:gutentags_file_list_command = 'rg --files'
endif

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
let g:did_install_default_menus = 1
let g:did_install_syntax_menu = 1 " save 50ms startup time
" }}}
" UI {{{
set colorcolumn=81,121 " column guide at 81 and 121 char
set number relativenumber " for easier execute macro
if (has('termguicolors')) " support true color (enable this when tmux support true color)
  let &t_8f = '\<Esc>[38;2;%lu;%lu;%lum'
  let &t_8b = '\<Esc>[48;2;%lu;%lu;%lum'
  set termguicolors
endif
set background=dark
colorscheme gruvbox
"}}}
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
augroup END

augroup VimrcRememberCursorPosition
  " Remember cursor position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

let g:php_namespace_sort_after_insert = 1
augroup PhpUseStatement
  " Press `<space>u` while on the class being used in normal mode to insert `use` statement
  autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
  " Press `<space>e` to expand to fully quailified class name
  autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>
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

augroup ale
  autocmd FileType php,javascript noremap <leader>wf :ALEFix<cr>
augroup END

augroup filetype_php
  autocmd FileType php set foldmethod=indent foldlevel=20
augroup END
" }}}
" Buffer & Tab Management {{{

" Copy current buffer path relative to root of VIM session to system clipboard
nnoremap <Leader>yp :let @*=expand("%")<cr>:echo "Copied file path to clipboard"<cr>
" Copy current filename to system clipboard
nnoremap <Leader>yf :let @*=expand("%:t")<cr>:echo "Copied file name to clipboard"<cr>
" Copy current buffer path without filename to system clipboard
nnoremap <Leader>yd :let @*=expand("%:h")<cr>:echo "Copied file directory to clipboard"<cr>
" Copy current method name to system clipboard
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
nnoremap <Leader>ym :CopyPhpMethodName<cr>

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
" Telescope config {{{
" fuzzy open file in current project with <space>p
nnoremap <silent> <leader>p :Telescope find_files<CR>
" List recent opened file <space>h
nnoremap <silent> <leader>h :Telescope oldfiles<CR>
" Jump to opened file (buffer) with <space><Enter>
nnoremap <silent> <leader><Enter> :Telescope buffers<CR>
" Jump to method or variable/attribute in current file <space>r
nnoremap <silent> <leader>r :Telescope lsp_document_symbols<CR>
" Jumt to lines in current buffer and search for string <space>/
nnoremap <silent> <leader>/ :Telescope current_buffer_fuzzy_find<CR>
command! Rg :Telescope live_grep
command! Tags :Telescope tags
" }}}
" EasyAlign config {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}
" Ale config {{{
let g:ale_linters = {
\   'php': ['phpcs', 'php'],
\   'vim': ['vint'],
\   'sh': ['shellcheck'],
\   'javascript': ['eslint'],
\}

let g:ale_fixers = {
\   'php': ['php_cs_fixer', 'phpcbf'],
\   'vim': ['remove_trailing_lines', 'trim_whitespace'],
\   'sh': ['shfmt'],
\   'json': ['fixjson'],
\   'javascript': ['eslint'],
\}
let g:ale_php_phpcs_standard ='psr2'
let g:ale_php_cs_fixer_options = '--rules=@PSR1,@PSR2,no_unused_imports'
let g:ale_php_phpmd_ruleset = '~/.config/code-rules/phpmd.xml'
let g:ale_php_phpcbf_standard = 'psr2'
let g:ale_completion_enabled = 0
let g:ale_sign_column_always = 1
let g:ale_sign_warning = '──'
let g:ale_sign_error = '══'
nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)
nmap ]r <Plug>(ale_next_error)
nmap [r <Plug>(ale_previous_error)
" }}}
" dirvish config {{{
let g:loaded_netrwPlugin = 0
let g:dirvish_mode = ':sort ,^.*[\/],'
command! -nargs=? -complete=dir Explore | exe 'silent Dirvish '.(empty('<args>')?'%':'<args>')
command! -nargs=? -complete=dir Sexplore belowright split | exe 'silent Dirvish '.(empty('<args>')?'%':'<args>')
command! -nargs=? -complete=dir Vexplore leftabove vsplit | exe 'silent Dirvish '.(empty('<args>')?'%':'<args>')
" }}}
" Sneak config {{{
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
let g:sneak#target_labels = ';sftunqwgjhmblkyd/SFGHLTUNRMQZ?0123456789'
" }}}
" compe config {{{
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true
let g:compe.source.treesitter = v:true
" }}}
" LSP {{{
lua << EOF
local nvim_lsp = require('lspconfig')
nvim_lsp.phpactor.setup {}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
 local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
 local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<Leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "phpactor" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
local saga = require('lspsaga')
saga.init_lsp_saga {
  border_style = "round",
}
EOF
" }}}
