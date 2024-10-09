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
  --
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
      { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete Other Buffers' },
      { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
      { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[w', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { ']w', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[W', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
      { ']W', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    },
    opts = {
      options = {
        -- stylua: ignore
        -- close_command = function(n) LazyVim.ui.bufremove(n) end,
        -- stylua: ignore
        -- right_mouse_command = function(n) LazyVim.ui.bufremove(n) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
}
