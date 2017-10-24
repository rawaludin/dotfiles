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
Plug 'tpope/vim-abolish'
Plug 'vim-scripts/BufOnly.vim' " used to close other buffer except the active one with :BufOnly
Plug 'justinmk/vim-sneak' " Jump to any location specified by two character
Plug 'gorkunov/smartpairs.vim' " easy expand selection

" ----- Working with PHP ----------------------------------------------
Plug 'arnaud-lb/vim-php-namespace' " insert php `use` statement automatically  by <Leader>u in normal mode
" Plug 'ludovicchabant/vim-gutentags' " Automatic tag generation when file saved / modified
" Plug 'joonty/vdebug'
" Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install -vvv' }

" Try LanguageServer-Protocol like vscode
" make sure disable xdebug to use this
Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install -vvv && composer run-script parse-stubs'}
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-completion-manager'
" requires phpactor for completion
Plug 'phpactor/phpactor' ,  {'do': 'composer install --prefer-dist -vvv'}
Plug 'roxma/ncm-phpactor'
Plug 'Shougo/echodoc.vim'

" ----- Working with Git ----------------------------------------------
Plug 'airblade/vim-gitgutter' " display each line git status
Plug 'tpope/vim-fugitive' " git inside vim
Plug 'tpope/vim-rhubarb' " github extension for fugitive

" ----- Working with Markdown ----------------------------------------------
" Plug 'plasticboy/vim-markdown' | Plug  'godlygeek/tabular', { 'for': 'markdown' } " better markdown highlight

" ----- Other text editing features -----------------------------------
Plug 'w0rp/ale' " linter
Plug 'Shougo/neosnippet'
" Plug 'SirVer/ultisnips' " text snippet
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Autocomplete. this one support neovim natively
" endif
Plug 'kylef/apiblueprint.vim' " syntax highlight for API Blueprint doc
Plug 'vimwiki/vimwiki' " personal note taker

" Auto generate ctags
Plug 'majutsushi/tagbar' " view ctags on sidebar

call plug#end()
" }}}

" General {{{
set autoread " detect latest change outside vim
set autowriteall " save buffer when switch to other buffer
set clipboard+=unnamedplus " share clipboard with OSX
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
augroup PHPStuff
  " reindex php tags async, doen't run if last command hasn't done
  autocmd BufWritePost *.php :call jobstart('[ ! -f tags.lock ] && touch tags.lock && ctags -R --languages=php --php-kinds=cfit && rm -rf tags.lock')
  " start LanguageServer-php-neovim
  autocmd FileType php LanguageClientStart
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
command! Strip call <SID>StripTrailingWhitespaces()
" }}}

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

" vim-airline {{{
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
" }}}

" Nerdtree {{{
" Open/close NERDTree Tabs with <space>t
" nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
nmap <silent> <leader>t :NERDTreeToggle<CR>
" Open synced tree with <space>st
map <silent> <leader>st :NERDTreeFind<CR>
" To have NERDTree always open on startup set this to 2
let g:nerdtree_tabs_open_on_console_startup = 0
" }}}

" fzf {{{
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
" }}}

" vim-gitgutter {{{
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1
" }}}

" vim-markdown {{{
" disable folding because performance, see https://github.com/plasticboy/vim-markdown/issues/162
let g:vim_markdown_folding_disabled=1
" disable indent when new paragraph with `o` from list
au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} setlocal indentexpr=''
" Close TOC after click enter on heading link
nnoremap <expr><enter> &ft=="qf" ? "<cr>:lcl<cr>" : (getpos(".")[2]==1 ? "i<cr><esc>": "i<cr><esc>l")
" }}}

" emmet-vim {{{
let g:user_emmet_install_global = 0
autocmd FileType html,css,php,js,jsx EmmetInstall
let g:user_emmet_leader_key='<Tab>'  " autocomplete emmet by <Tab><comma>
" }}}

" deoplete.nvim {{{
" Always enable (to manual enable :DeopleteEnable / :DeopleteDisable)
" Make sure you have setup ctags for this to work
let g:deoplete#enable_at_startup = 1
" use phpcd for php completion
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
let g:deoplete#ignore_sources.php = ['omni']
" }}}

" vim-php-namespace {{{
" Press `<space>u` while on the class being used in normal mode to insert `use`
" statement
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
" Press `<space>e` to expand to fully quailified class name
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>
" }}}

" tmuxline {{{
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
" }}}

" tagbar {{{
" Open/close tagbar with <space>g
nmap <silent> <leader>g :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)
" }}}

" ale {{{
let g:ale_linters = {
\   'php': ['php -l', 'phpcs', 'phpmd'],
\}
let g:ale_php_phpcs_standard='~/.config/code-rules/phpcs.xml'
let g:ale_php_phpmd_ruleset='~/.config/code-rules/phpmd.xml'
let g:ale_set_loclist=1
let g:ale_lint_delay = 1000
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

inoremap <silent> <c-u> <c-r>=cm#sources#neosnippet#trigger_or_popup("\<Plug>(neosnippet_expand_or_jump)")<cr>
vmap <c-u> <Plug>(neosnippet_expand_target)
" expand parameters
let g:neosnippet#enable_completed_snippet=1
" }}}

" run from property micros project
function! GenerateDomain(domain, table, relationship, config, const, payload_field, foreign)
  " contracts
  execute '!cp -rf ./app/Contracts/Basement app/Contracts/'.a:domain
  execute "!find ./app/Contracts/".a:domain." -type f | xargs sed -i '' -e 's/Basement/".a:domain."/g'"
  execute "!find ./app/Contracts/".a:domain." -type f | sed 'p;s/Basement/".a:domain."/g' | xargs -n2 mv"

  " domain
  execute '!cp -rf app/Domains/Basement app/Domains/'.a:domain
  execute "!find ./app/Domains/".a:domain." -type f | sed 'p;s/Basement/".a:domain."/g' | xargs -n2 mv"
  execute "!find ./app/Domains/".a:domain." -type f | xargs sed -i '' -e 's/Basement/".a:domain."/g'"
  execute "!find ./app/Domains/".a:domain." -type f | xargs sed -i '' -e 's/basements/".a:table."/g'"

  " Infrastructures
  execute '!cp -rf app/Infrastructures/Basement app/Infrastructures/'.a:domain
  execute "!find ./app/Infrastructures/".a:domain." -type f | sed 'p;s/Basement/".a:domain."/g' | xargs -n2 mv"
  execute "!find ./app/Infrastructures/".a:domain." -type f | xargs sed -i '' -e 's/Basement/".a:domain."/g'"
  execute "!find ./app/Infrastructures/".a:domain." -type f | xargs sed -i '' -e 's/basements/".a:relationship."/g'"

  " config
  execute '!cp -rf ./config/packages/basement.php config/packages/'.a:config.'.php'
  execute "!sed -i '' -e 's/Basement/".a:domain."/g' config/packages/".a:config.'.php'

  " test
  execute '!cp -rf ./tests/Domains/Basement ./tests/Domains/'.a:domain
  execute "!find ./tests/Domains/".a:domain." -type f | sed 'p;s/Basement/".a:domain."/g' | xargs -n2 mv"
  execute "!find ./tests/Domains/".a:domain." -type f | xargs sed -i '' -e 's/Basement/".a:domain."/g'"
  execute '!cp -rf ./tests/Infrastructures/Basement ./tests/Infrastructures/'.a:domain
  execute "!find ./tests/Infrastructures/".a:domain." -type f | sed 'p;s/Basement/".a:domain."/g' | xargs -n2 mv"
  execute "!find ./tests/Infrastructures/".a:domain." -type f | xargs sed -i '' -e 's/Basement/".a:domain."/g'"

  " factory
  execute "!echo '$factory->define(\\App\\Domains\\".a:domain."\\".a:domain."Eloquent::class, function (Faker\\Generator $faker) {' >> database/factories/StructureFactory.php"
  execute "!echo '   return [' >> database/factories/StructureFactory.php"
  if a:const != '0'
    execute "!echo \"        'name' => \\$faker->randomElement(\\App\\Contracts\\GreenMarketing\\GreenMarketingInterface::".a:const.")\" >> database/factories/StructureFactory.php"
  else
    execute "!echo \"        'name' => \\$faker->text\" >> database/factories/StructureFactory.php"
  endif
  execute "!echo '    ];' >> database/factories/StructureFactory.php"
  execute "!echo '});' >> database/factories/StructureFactory.php"

  " Controller Assertion
  execute '!cp -rf ./tests/Controllers/Concerns/StructureAssertion/Basement.php ./tests/Controllers/Concerns/StructureAssertion/'.a:domain.'.php'
  execute "!sed -i '' -e 's/Basement/".a:domain."/g' ./tests/Controllers/Concerns/StructureAssertion/".a:domain.".php"
  execute "!sed -i '' -e 's/prop_basements/prop_".a:table."/g' ./tests/Controllers/Concerns/StructureAssertion/".a:domain.".php"
  execute "!sed -i '' -e 's/basement_id/".a:foreign."/g' ./tests/Controllers/Concerns/StructureAssertion/".a:domain.".php"
  execute "!sed -i '' -e 's/basement/".a:payload_field."/g' ./tests/Controllers/Concerns/StructureAssertion/".a:domain.".php"

  " run test
  execute "!ts ./tests/Domains/".a:domain.' && ts ./tests/Infrastructures/'.a:domain
endfunction

" run on tests/Controllers/Concerns/StructureAssertion/Structure.php
function! ControllerConcern(Domain, field_name)
  " trait
  call setreg('/',';')
  execute 'normal! ggnnnn'
  call setreg('0',a:Domain)
  execute "normal! i,\<CR>\<C-R>0\<ESC>"
  " payload
  call setreg('/','appendStructureGroupPayload')
  execute 'normal! ggnj%2k'
  let l:payloadAssert = "$this->savedPayload['structure.".a:field_name."'] = $this->append".a:Domain."Payload($data);"
  execute "normal! i".l:payloadAssert."\<ESC>==o\<ESC>"
  " structure
  call setreg('/','appendStructureGroupStructure')
  execute 'normal! ggnj%2k'
  let l:structureAssert = '$jsonStructure = $this->append'.a:Domain.'Structure($jsonStructure);'
  execute "normal! i".l:structureAssert."\<ESC>==o\<ESC>"
  " response
  call setreg('/','seeStructureGroupResponse')
  execute 'normal! ggnj%k$xo'
  let l:responseAssert = "->see".a:Domain."Response($this->savedPayload['structure.".a:field_name."']);"
  execute "normal! i".l:responseAssert."\<ESC>=="
  " record
  call setreg('/','seeStructureGroupRecords')
  execute 'normal! ggnj%k$xo'
  let l:recordAssert = "->see".a:Domain."Record($propertyId, $structureId, $this->savedPayload['structure.".a:field_name."']);"
  execute "normal! i".l:recordAssert."\<ESC>==f,;a\<CR>\<ESC>Vk<"
  " run test
  execute "!ts tests/Controllers/PropertyControllerTest.php"
endfunction

" run from parent repository
function! RepositorySync(Domain, Method)
  let l:repo = g:Abolish.camelcase(a:Domain).'Repository'
  " use
  execute "normal! gg]]"
  call setreg('/', 'use')
  execute "normal! N"
  let l:use = 'use App\Contracts\'.a:Domain.'\'.a:Domain.'RepositoryInterface;'
  execute "normal! o".l:use."\<ESC>"
  " construct
  call setreg('/', '__construct')
  let l:construct = a:Domain.'RepositoryInterface $'.l:repo
  let l:setRepo = '$this->'.l:repo.' = $'.l:repo.';'
  execute "normal! nf(%kA,\<ESC>o".l:construct."\<ESC>jj%O".l:setRepo."\<ESC>"
  " sync
  call setreg('/', 'syncRelated')
  let l:sync = '$this->'.l:repo.'->sync($result, $entity->get'.a:Method.'());'
  execute "normal! ggnj%O".l:sync."\<ESC>"
endfunction

function! RepoInterfaceSync(Domain)
  let l:repo = g:Abolish.camelcase(a:Domain).'Repository'
  " use
  execute "normal! gg]]"
  call setreg('/', 'use')
  execute "normal! N"
  let l:use = 'use App\Contracts\'.a:Domain.'\'.a:Domain.'RepositoryInterface;'
  execute "normal! o".l:use."\<ESC>"
  " construct
  call setreg('/', '__construct')
  let l:construct = a:Domain.'RepositoryInterface $'.l:repo
  let l:setRepo = '$this->'.l:repo.' = $'.l:repo.';'
  execute "normal! nf(%kA,\<ESC>o".l:construct."\<ESC>jj%O".l:setRepo."\<ESC>"
endfunction

function! RepoSyncTest(Domain, FieldMethod, field_name, const)
  " use
  execute "normal! gg]]"
  call setreg('/', 'use')
  execute "normal! N"
  let l:use = 'use App\Contracts\'.a:Domain.'\'.a:Domain.'RepositoryInterface;'
  execute "normal! o".l:use."\<ESC>"
  " setup
  let l:repo = g:Abolish.camelcase(a:Domain).'Repository'
  call setreg('/', 'persistenceRepository')
  let l:repoSet = '$this->'.l:repo.' = m::mock('.a:Domain.'RepositoryInterface::class);'
  let l:repoConstruct = '$this->'.l:repo
  execute "normal! ggnO".l:repoSet."\<ESC>0"
  call setreg('/', 'new StructureRepository')
  execute "normal! nf(%kA,\<CR>".l:repoConstruct."\<ESC>=="
  " mockSync
  call setreg('/', 'mockSync')
  if (a:const == 0)
    let l:mock1 = "$data['".a:field_name."'] = $faker->words(2, false);"
  else
    let l:mock1 = "$data['".a:field_name."'] = $faker->randomElements(StructureInterface::".a:const.");"
  endif
  let l:mock2 = "$this->".l:repo."->shouldReceive('sync')->with($model, $data['".a:field_name."'])->once();"
  let l:mock3 = "$model->shouldReceive('get".a:FieldMethod."')->andReturn($data['".a:field_name."']);"
  execute "normal! ggnj%ko".l:mock1."\<ESC>o".l:mock2."\<ESC>o".l:mock3."\<ESC>"
  " run test
  execute "!ts %"
endfunction
