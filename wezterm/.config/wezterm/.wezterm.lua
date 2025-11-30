-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
-- not showing any tabs because I plan on using all sessions through tmux.
config.hide_tab_bar_if_only_one_tab = true

-- or, changing the font size and color scheme.
config.font_size = 20

-- config.use_cap_height_to_scale_fallback_fonts = true

config.font = wezterm.font_with_fallback({
	{ family = "JetBrains Mono", weight = "Bold" },
	{ family = "Symbols Nerd Font Mono", weight = "Regular" },
	{ family = "FiraCodeiScript Nerd Font", weight = "Bold" },
	{ family = "MesloLGM Nerd Font Mono", weight = "Bold" },
})

config.font_rules = {
	{
		italic = true,
		font = wezterm.font_with_fallback({
			{ family = "Fira Code iScript", weight = "Bold", italic = true },
		}),
	},
}
-- config.color_scheme = "Dracula"
config.colors = require("cyberdream")
config.scrollback_lines = 10000 -- Increase scrollback buffer

config.enable_kitty_graphics = true
config.term = "xterm-256color"
-- Enable font ligatures
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }

-- Cursor configuration
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Ease"
config.cursor_blink_ease_out = "Ease"
config.cursor_thickness = 1

config.allow_square_glyphs_to_overflow_width = "Always" -- or consider "Always"
-- Remove native Windows title bar
config.window_decorations = "RESIZE"

-- Set WSL Ubuntu as default shell
config.default_prog = { "wsl.exe", "--distribution", "Ubuntu" }

-- Launch menu configuration for command palette
config.launch_menu = {
	{
		label = "PowerShell (Admin)",
		args = { "gsudo.exe", "powershell.exe", "-NoLogo" },
	},
	{
		label = "PowerShell",
		args = { "powershell.exe" },
	},
	{
		label = "PowerShell Core",
		args = { "pwsh.exe" },
	},
	{
		label = "Command Prompt",
		args = { "cmd.exe" },
	},
	{
		label = "WSL Ubuntu",
		args = { "wsl.exe", "--distribution", "Ubuntu" },
	},
}
-- Tab bar configuration
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.show_tab_index_in_tab_bar = false
config.tab_max_width = 32

-- Custom tab title formatting
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab.tab_title
	if title and #title > 0 then
		title = title
	else
		title = tab.active_pane.title
	end

	-- Truncate title if too long
	if #title > max_width - 4 then
		title = string.sub(title, 1, max_width - 7) .. "..."
	end

	-- Add padding and icons
	local icon = " " -- Terminal icon
	if tab.is_active then
		return {
			{ Text = " " .. icon .. title .. " " },
		}
	else
		return {
			{ Text = " " .. icon .. title .. " " },
		}
	end
end)

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Window frame font (fallback for command palette)
config.window_frame = {
	font = wezterm.font("Fira Code iscript", { weight = "Bold", italic = true }),
	font_size = 18,
}

-- Command palette configuration
config.command_palette_font_size = 20
config.command_palette_fg_color = "#f8f8f2" -- Dracula foreground
config.command_palette_bg_color = "#282a36" -- Dracula background
-- Finally, return the configuration to wezterm:s
return config
