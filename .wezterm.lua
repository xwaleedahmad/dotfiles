local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- General
config.font_size = 15
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.color_scheme = "Catppuccin Mocha"

config.colors = {
	cursor_bg = "#B4BEFE",
	cursor_border = "#B4BEFE",
}

config.window_decorations = "NONE"
config.enable_tab_bar = false
config.window_background_opacity = 0.94
config.underline_thickness = "2px"
config.default_cursor_style = "SteadyUnderline"
config.window_close_confirmation = "NeverPrompt"

return config
