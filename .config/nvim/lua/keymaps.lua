-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- quit
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

-- save file
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- run code
-- TODO:make it dynamic per programming language
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<leader>cr', '<cmd>RustRun<cr>', { desc = '[C]ode [R]un (Rust)' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Buffer & Tab Management
-- Copy current buffer path relative to root of VIM session to system clipboard
vim.api.nvim_set_keymap('n', '<Leader>yp', [[<Cmd>let @*=expand("%")<CR><Cmd>echo "Copied file path to clipboard"<CR>]], { noremap = true, silent = true })

-- Copy current filename to system clipboard
vim.api.nvim_set_keymap('n', '<Leader>yf', [[<Cmd>let @*=expand("%:t")<CR><Cmd>echo "Copied file name to clipboard"<CR>]], { noremap = true, silent = true })

-- Copy current buffer path without filename to system clipboard
vim.api.nvim_set_keymap(
  'n',
  '<Leader>yd',
  [[<Cmd>let @*=expand("%:h")<CR><Cmd>echo "Copied file directory to clipboard"<CR>]],
  { noremap = true, silent = true }
)

-- Undo close buffer by <Ctrl><shift>t
vim.api.nvim_set_keymap('n', '<C-T>', ':e #<CR>', { noremap = true, silent = true, desc = 'Undo close buffer' })

-- New empty buffer by space+n
vim.api.nvim_set_keymap('n', '<Leader>n', ':enew<CR>', { noremap = true, silent = true, desc = 'New empty buffer' })

-- Jump to tab mapping
vim.api.nvim_set_keymap('n', '[t', ':tabprevious<CR>', { noremap = true, silent = true, desc = 'Previous tab' })
vim.api.nvim_set_keymap('n', ']t', ':tabnext<CR>', { noremap = true, silent = true, desc = 'Next tab' })
vim.api.nvim_set_keymap('n', '{t', ':tabfirst<CR>', { noremap = true, silent = true, desc = 'First tab' })
vim.api.nvim_set_keymap('n', '}t', ':tablast<CR>', { noremap = true, silent = true, desc = 'Last tab' })

-- Jump to quickfix mapping
vim.api.nvim_set_keymap('n', '[q', ':cprevious<CR>', { noremap = true, silent = true, desc = 'Previous quickfix' })
vim.api.nvim_set_keymap('n', ']q', ':cnext<CR>', { noremap = true, silent = true, desc = 'Next quickfix' })

-- Jump to location-list mapping
vim.api.nvim_set_keymap('n', '[l', ':lprevious<CR>', { noremap = true, silent = true, desc = 'Previous location-list' })
vim.api.nvim_set_keymap('n', ']l', ':lnext<CR>', { noremap = true, silent = true, desc = 'Next location-list' })

-- Delete buffer <space>d
vim.api.nvim_set_keymap('n', '<Leader>d', ':bd<CR>', { noremap = true, silent = true, desc = 'Delete buffer' })

-- Close all buffers <space>D
vim.api.nvim_set_keymap('n', '<Leader>D', ':bufdo bd<CR>', { noremap = true, silent = true, desc = 'Delete all buffer' })

-- Jump to last tab <space>Tab
vim.g.lasttab = 1
vim.api.nvim_set_keymap('n', '<Leader><Tab>', [[<Cmd>exe "tabn ".g:lasttab<CR>]], { noremap = true, silent = true, desc = 'Jump to previous [tab]' })

-- Track the last tab
vim.api.nvim_create_augroup('SetLastTab', {})
vim.api.nvim_create_autocmd('TabLeave', {
  group = 'SetLastTab',
  callback = function()
    vim.g.lasttab = vim.fn.tabpagenr()
  end,
})

-- Jump to previous active buffer
vim.keymap.set('n', '<leader>p', '<cmd>b#<CR>', { desc = 'Jump to [P]revious buffer' })

-- Q to replay, qq to record macro
vim.api.nvim_set_keymap('n', 'Q', '@q', { noremap = true, silent = true, desc = 'Record macro' })

-- Map arrow keys to resize windows
vim.api.nvim_set_keymap('n', '<Left>', ':vertical resize +2<CR>', { noremap = true, silent = true, desc = 'Grow vertical window' })
vim.api.nvim_set_keymap('n', '<Right>', ':vertical resize -2<CR>', { noremap = true, silent = true, desc = 'Shrink vertical window' })
vim.api.nvim_set_keymap('n', '<Up>', ':resize -2<CR>', { noremap = true, silent = true, desc = 'Shrink horizontal window' })
vim.api.nvim_set_keymap('n', '<Down>', ':resize +2<CR>', { noremap = true, silent = true, desc = 'Grow horizontal window' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Save any unsaved buffer on focus lost
vim.api.nvim_create_autocmd('FocusLost', {
  group = vim.api.nvim_create_augroup('AutoWriteOnLostFocus', { clear = true }),
  pattern = '*',
  callback = function()
    -- Silent write command
    vim.cmd 'silent! wa'
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('close_with_q', { clear = true }),
  pattern = {
    'PlenaryTestPopup',
    'grug-far',
    'help',
    'lspinfo',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
    'dbout',
    'gitsigns-blame',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', {
      buffer = event.buf,
      silent = true,
      desc = 'Quit buffer',
    })
  end,
})

-- vim: ts=2 sts=2 sw=2 et
