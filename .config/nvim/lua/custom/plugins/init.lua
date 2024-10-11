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
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'mini',
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    -- stylua: ignore
    -- keys = {
    --   { "<leader>sn", "", desc = "+noice"},
    --   { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    --   { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    --   { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    --   { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    --   { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    --   { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
    --   { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
    --   { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
    -- },
    config = function(_, opts)
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == 'lazy' then
        vim.cmd [[messages clear]]
      end
      require('noice').setup(opts)
    end,
  },
}
