local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Rosé Pine (Gogh)"
-- config.color_scheme = "Catppuccin Macchiatto"
config.font = wezterm.font('FiraCode Nerd Font')
config.window_background_opacity = 0.6
config.enable_tab_bar = false

return config
