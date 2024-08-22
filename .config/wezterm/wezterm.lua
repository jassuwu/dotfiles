local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- cuz wayland on nvidia sucks
config.enable_wayland = false
-- needed only for xorg
config.max_fps = 144

-- my usual
-- config.font = wezterm.font('FiraCode Nerd Font')

-- goofy ahh 💀
config.font = wezterm.font('Comic Code Ligatures')

-- 1:1 font baby
-- config.font = wezterm.font('Mx437_IBM_BIOS')

config.color_scheme = "Tokyo Night"
-- config.color_scheme = "Rosé Pine (Gogh)"
-- config.color_scheme = "Catppuccin Macchiatto"
config.window_background_opacity = 0.9

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
