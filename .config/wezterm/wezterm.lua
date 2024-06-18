local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- needed only for xorg
config.max_fps = 144

-- my usual
-- config.font = wezterm.font('FiraCode Nerd Font')

-- goofy ahh 💀
config.font = wezterm.font('Comic Code Ligatures')

config.color_scheme = "Rosé Pine (Gogh)"
-- config.color_scheme = "Catppuccin Macchiatto"
config.window_background_opacity = 0.6

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
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config
