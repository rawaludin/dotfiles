local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.color_scheme = 'tokyonight_night'
config.font = wezterm.font { family = 'VictorMono Nerd Font Mono', weight = 'Bold' }
-- TODO: make font size 15 on mac air, 18 on mac mini
config.font_size = 15
config.line_height = 1.2
-- Slightly transparent and blurred background
-- config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 30
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.window_frame = {
  font = wezterm.font { family = 'VictorMono Nerd Font Mono', weight = 'Bold' },
  font_size = 12,
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
