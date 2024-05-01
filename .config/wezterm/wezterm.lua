local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Rosé Pine (Gogh)"
config.font = wezterm.font('FiraCode Nerd Font')
config.window_background_opacity = 0.7

return config
