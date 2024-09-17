local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- cuz wayland on nvidia sucks
config.enable_wayland = false
config.front_end = "WebGpu"

config.font = wezterm.font('FiraCode Nerd Font')
config.font_size = 16.0

config.color_scheme = "Rosé Pine (Gogh)"
config.window_background_opacity = 1

config.colors = {
  tab_bar = {
    background = '#222',

    active_tab = {
      bg_color = '#000',
      fg_color = '#fff',
      intensity = 'Normal',
      underline = 'None',
      italic = true,
      strikethrough = false,
    },

    inactive_tab = {
      bg_color = '#222',
      fg_color = '#808080',
      intensity = 'Half'
    },
  }
}

-- config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 1024

config.window_padding = {
  left = 6,
  right = 6,
  top = 6,
  bottom = 6,
}

-- drivin' me nuts
config.audible_bell = "Disabled"

return config
