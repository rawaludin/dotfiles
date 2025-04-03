local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.color_scheme = 'tokyonight_night'
config.enable_tab_bar = false -- Using tmux instead
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font { family = 'VictorMono Nerd Font', weight = 'Bold' }
-- config.font = wezterm.font { family = 'DroidSansM Nerd Font' }
config.cursor_blink_rate = 0
-- TODO: make font size 15 on mac air, 18 on mac mini
config.font_size = 15
config.line_height = 1.2
config.mouse_bindings = {
  -- Open a link
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = 'OpenLinkAtMouseCursor',
  },
}
config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = 'RESIZE'
-- config.window_padding = {
--   left = 5,
--   right = 5,
--   top = 0,
--   bottom = 0,
-- }

-- Set custom padding (top, right, bottom, left)
config.window_padding = {
  left = 6,
  right = 2,
  top = 2,
  bottom = 0, -- Reduced bottom padding
}

wezterm.on('update-status', function(window)
  -- Grab the utf8 character for the "powerline" left facing
  -- solid arrow.
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  -- Grab the current window's configuration, and from it the
  -- palette (this is the combination of your chosen colour scheme
  -- including any overrides).
  local color_scheme = window:effective_config().resolved_palette
  local bg = color_scheme.background
  local fg = color_scheme.foreground

  window:set_right_status(wezterm.format {
    -- First, we draw the arrow...
    { Background = { Color = 'none' } },
    { Foreground = { Color = bg } },
    { Text = SOLID_LEFT_ARROW },
    -- Then we draw our text
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = ' ' .. wezterm.hostname() .. ' ' },
  })
end)

return config
