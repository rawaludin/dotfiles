" idea collections
"
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

function! Macro()
  set ignorecase
  set textwidth=80
  " turn to $table->tipe..('field');(tipe..)...
  execute "normal! dt`r'f`r'"
  execute "normal! ldt(lyi("
  execute "normal! 0i$table->\<ESC>pa(\<ESC>f';a);\<ESC>"
  " save description as comment if type is lookup
  " for easier setup relationship manually
  let notLookup = ["string", "boolean", "number"]
  execute "normal! 0f;f)yb"
  let type = @"
  " " delete rest of text
  execute "normal! 0f;ld$"
  if index(notLookup, type) == -1
    " paste text, and reformat to 80 char limit
    execute "normal! O// \<ESC>pv`[`]gqj"
  endif

  " add nullable if not required
  execute "normal! 0f>lye"
  let type = @"
  if type == "required"
    " delete required text
    execute "normal! 0f>ldf\<space>\<ESC>"
  else
    " add ->nullable()
    execute "normal! $i->nullable()\<ESC>"
  endif

  " change
  " number => integer
  " string => no change
  set number relativenumber
  " boolean => no change
  " other string, and put comment
  execute 'normal! 0f>lye'
  let type = @"
  if type == 'number'
    execute 'normal! 0f>lceinteger\<ESC>'
  elseif type == 'string'
    execute 'normal! 0'
  elseif type == 'boolean'
    execute 'normal! 0'
  else
    execute 'normal! 0f>lcestring\<ESC>'
  endif
endfunction
