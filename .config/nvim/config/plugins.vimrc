"******************************************************************************
" Setting: Plugin
"******************************************************************************
"
"
" Plugin: terryma/vim-expand-region ----
" expand selection in visual mode by v
vmap v <Plug>(expand_region_expand)
" shrink selection in visual mode by ctrl+v
vmap <C-v> <Plug>(expand_region_shrink)
" -----------------------------------------------------------------------------


" Plugin: tobyS/pdv ----
"
let g:pdv_template_dir = $HOME ."/.config/nvim/pdv_template"
nnoremap <C-p> :call pdv#DocumentWithSnip()<CR>
" -----------------------------------------------------------------------------


" Plugin: SirVer/ultisnips ----
"
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
" -----------------------------------------------------------------------------


" Plugin: junegunn/goyo.vim ----
"
" activate goyo when opening markdown
" au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} Goyo
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown " set syntax as markdown when opening md
" -----------------------------------------------------------------------------


" Plugin: junegunn/vim-easy-align ----
"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" -----------------------------------------------------------------------------


" Plugin: easymotion/vim-easymotion ----
"
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Jump to anywhere you want with minimal keystrokes, with just one key
" binding.
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1"
" -----------------------------------------------------------------------------


" Plugin: altercation/vim-colors-solarized -----
"
" Toggle this to "light" for light colorscheme
set background=dark
" set background=light

" Uncomment the next line if your terminal is not configured for solarized
let g:solarized_contrast = "high"
" -----------------------------------------------------------------------------


" Plugin: vim-airline/vim-airline ----
"
" set theme
let g:airline_theme = 'tomorrow'
" let g:airline_theme = 'papercolor'
" let g:airline_theme = 'solarized'
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
" -----------------------------------------------------------------------------


" Plugin: scrooloose/nerdtree ----
"
" Open/close NERDTree Tabs with <space>t
" nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
nmap <silent> <leader>t :NERDTreeToggle<CR>
" Open synced tree with <space>ts
nmap <silent> <leader>ts :NERDTreeFind<CR>
" To have NERDTree always open on startup set this to 1
let g:nerdtree_tabs_open_on_console_startup = 0
" -----------------------------------------------------------------------------


" Plugin: junegunn/fzf ----
" 
" use ag for searching, search hidden, ignore .gitignore, skip whats in .git
let $FZF_DEFAULT_COMMAND = 'ag --hidden -U --ignore .git -g ""' "
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
" Generate tags only when files is opened or saved
let g:easytags_events = ['BufReadPost', 'BufWritePost']
" asynchronous tag generate
let g:easytags_async = 1
" resolve symbolic links in pathname (useful for unix)
let g:easytags_resolve_links = 1
" suppress the warning on startup if ctags is not found or not recent enough
" let g:easytags_suppress_ctags_warning = 1
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
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
" autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

" Press `<space>e` to expand to fully quailified class name
function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
" autocmd FileType php inoremap <Leader>e <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>
" -----------------------------------------------------------------------------


" Plugin: Simple php formatter using php-cs-fixer ----
"
autocmd FileType php noremap <leader>wf :!php-cs-fixer fix "%" --level=psr2<cr><cr>
" -----------------------------------------------------------------------------


" Plugin: fatih/vim-go ----
"
" format with goimports and gofmt when saving go file
let g:go_fmt_command = "goimports"
" -----------------------------------------------------------------------------


" Plugin: edkolev/tmuxline.vim ----
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
" -----------------------------------------------------------------------------


" Plugin: majutsushi/tagbar ----
" 
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)
" -----------------------------------------------------------------------------
