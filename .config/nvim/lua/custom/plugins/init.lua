-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Temporary plugins to generate tmuxline
  -- {
  --   'edkolev/tmuxline.vim',
  --   cmd = 'Tmuxline',
  --   config = function()
  --     vim.g.tmuxline_preset = {
  --       a = '#S',
  --       win = { '#W' },
  --       cwin = { '#W#{?window_zoomed_flag, *Z,}' },
  --       y = { '%a, %b %d' },
  --       z = '%R#(battery-info)',
  --       options = { status_justify = 'left' },
  --     }
  --   end,
  -- },
  --
  -- {
  --   'vim-airline/vim-airline',
  --   dependencies = {
  --     'vim-airline/vim-airline-themes',
  --     'edkolev/tmuxline.vim',
  --   },
  --   config = function()
  --     -- Enable airline extensions
  --     vim.g['airline#extensions#tabline#enabled'] = 1
  --     vim.g['airline#extensions#tmuxline#enabled'] = 1
  --     vim.g['airline#extensions#whitespace#enabled'] = 1
  --     vim.g['airline#extensions#hunks#enabled'] = 1
  --
  --     -- Other airline settings
  --     vim.g.airline_powerline_fonts = 1
  --     vim.g.airline_skip_empty_sections = 1
  --   end,
  -- },
}
