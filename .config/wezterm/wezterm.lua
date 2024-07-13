--
-- ██╗    ██╗███████╗███████╗████████╗███████╗██████╗ ███╗   ███╗
-- ██║    ██║██╔════╝╚══███╔╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
-- ██║ █╗ ██║█████╗    ███╔╝    ██║   █████╗  ██████╔╝██╔████╔██║
-- ██║███╗██║██╔══╝   ███╔╝     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
-- ╚███╔███╔╝███████╗███████╗   ██║   ███████╗██║  ██║██║ ╚═╝ ██║
--  ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
-- A GPU-accelerated cross-platform terminal emulator
-- https://wezfurlong.org/wezterm/

local wezterm = require("wezterm")

require('status').enable()

local h = require("helpers")
-- local keys = require("keys")
local parallax = require("parallax")

-- for random
local wallpapers_random_blob = h.get_conf_folder() .. "\\wallpapersforrandom\\" .. "**"

local dark_opacity = 0.75
local light_opacity = 0.8


local config = {}

config.check_for_updates = false
config.warn_about_missing_glyphs = false

config.adjust_window_size_when_changing_font_size = false
config.debug_key_events = false
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = false
config.use_fancy_tab_bar = false
config.enable_scroll_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.min_scroll_bar_height = '2cell'
config.colors = {
    scrollbar_thumb = 'white',
    foreground = '#d0d0d0',
    background = '#212121',
    cursor_bg = '#d0d0d0',
    cursor_border = '#d0d0d0',
    cursor_fg = '#151515',
    selection_bg = 'teal',
    selection_fg = '#d0d0d0',
    ansi = { '#151515', '#ac4142', '#7e8e50', '#e5b567', '#6c99bb', '#9f4e85', '#7dd6cf', '#d0d0d0' },
    brights = { '#505050', '#ac4142', '#7e8e50', '#e5b567', '#6c99bb', '#9f4e85', '#7dd6cf', '#f5f5f5' },
    tab_bar = {
      active_tab = {
        bg_color = '#313638',
        fg_color = '#FFFFFF',
      },
      inactive_tab = {
        bg_color = '#1e1e1e',
        fg_color = '#71797E',
      },
    },
}


config.font_size =  12
config.line_height = 1.1
config.font = wezterm.font_with_fallback({
		"JetBrains Mono",
        "SpaceMono Nerd Font",
		-- "CommitMono",
		-- "Monaspace Argon",
		-- "Monaspace Krypton",
		-- "Monaspace Neon",
		-- "Monaspace Radon",
		-- "Monaspace Xenon",
		{ family = "Symbols Nerd Font Mono" },
})

config.color_scheme = h.get_color_scheme()

config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

config.set_environment_variables = {
	BAT_THEME = h.is_dark() and "Catppuccin-mocha" or "Catppuccin-latte",
	LC_ALL = "en_US.UTF-8",
	-- TODO: audit what other variables are needed
}

-- uncomment and change order to apply
-- config.enable_scroll_bar = true
-- config.background = parallax.set("alienship")

-- uncomment and change order to apply
-- config.enable_scroll_bar = false
-- config.background = {
-- 	h.get_wallpaper_by_path(h.generate_anim_folder("blue-lines")),
-- 	h.get_background(dark_opacity, light_opacity),
-- }

config.enable_scroll_bar = false
config.background = {
	h.get_background(dark_opacity, light_opacity),
}


wezterm.on("user-var-changed", function(window, pane)
	-- local appearance = window:get_appearance()
	-- local is_dark = appearance:find("Dark")
	local overrides = window:get_config_overrides() or {}
	wezterm.log_info("name", name)
	wezterm.log_info("value", value)

	window:set_config_overrides(overrides)
end)

function increase_opacity()
	if dark_opacity <= 1.00 then
		dark_opacity = dark_opacity + 0.10
	end
end

function decrease_opacity()
	if dark_opacity >= 0.00 then
		dark_opacity = dark_opacity - 0.10
	end
end

wezterm.on('increase-opacity', function(window, pane)
	local overrides = window:get_config_overrides() or {}
	
	increase_opacity()
	overrides.background = {
		h.get_background(dark_opacity, light_opacity),
	}
	window:set_config_overrides(overrides)
end)

wezterm.on('decrease-opacity', function(window, pane)
	local overrides = window:get_config_overrides() or {}
	
	decrease_opacity()
	overrides.background = {
		h.get_background(dark_opacity, light_opacity),
	}
	window:set_config_overrides(overrides)
end)

local profiles = {
    [1] = "tranparent",
	[2] = "grayed",
	[3] = "parallax-alienship",
    [4] = "animated-ai-speech",
    [5] = "animated-blue-lines",
    [6] = "animated-random",
}

local profile_number = 1
function profile_alternator(overrides)	
	profile_number = profile_number + 1
	if profile_number > #profiles then
		profile_number = 1
	end
	local selected_profile = profiles[profile_number]

	if selected_profile == "animated-random" then
		overrides.enable_scroll_bar = false
		overrides.background = {
			h.get_randor_wallpaper(wallpapers_random_blob),
			h.get_background(dark_opacity, light_opacity),
		}
	end

	if selected_profile == "grayed" then
		overrides.enable_scroll_bar = false
		overrides.background = {
			{ source = { Color = '#282828' }, opacity = 0.95, width = '100%', height = '100%' },    
		}
	end

	if selected_profile == "animated-ai-speech" then
		overrides.enable_scroll_bar = false
		overrides.background = {
			h.get_wallpaper_by_path(h.generate_anim_folder("ai-speech")),
			h.get_background(dark_opacity, light_opacity),
		}
	end

	if selected_profile == "animated-blue-lines" then
		overrides.enable_scroll_bar = false
		overrides.background = {
			h.get_wallpaper_by_path(h.generate_anim_folder("blue-lines")),
			h.get_background(dark_opacity, light_opacity),
		}
	end
	
	if selected_profile == "parallax-alienship" then
		overrides.enable_scroll_bar = true
		overrides.background = parallax.set("alienship")	
	end

	if selected_profile == "tranparent" then
		overrides.enable_scroll_bar = false
		overrides.background = {
			h.get_background(dark_opacity, light_opacity),
		}
	end

end

local counter = false
wezterm.on('toggle-backgrounds', function(window, pane)
	wezterm.log_info("name", name)
	wezterm.log_info("value", value)
	local overrides = window:get_config_overrides() or {}
	profile_alternator(overrides)
	window:set_config_overrides(overrides)
end)

config.disable_default_key_bindings = true
config.keys = {
	{
		mods = 'CTRL|SHIFT',
		key = 'p',
		action = wezterm.action.EmitEvent 'toggle-backgrounds',
	},
	{
		mods = 'CTRL|SHIFT',
		key = '-',
		action = wezterm.action.EmitEvent 'decrease-opacity',
	},
	{
		mods = 'CTRL|SHIFT',
		key = '+',
		action = wezterm.action.EmitEvent 'increase-opacity',
	},
	{
	  key = 'Enter',
	  mods = 'ALT',
	  action = wezterm.action.ToggleFullScreen,
	},
	{
		key = 'c',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.CopyTo 'Clipboard',
	},
	{
		key = 'v',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.PasteFrom 'Clipboard',
	},
	{
		key = '-',
		mods = 'CTRL',
		action = wezterm.action.DecreaseFontSize,
	},
	{
		key = '+',
		mods = 'CTRL',
		action = wezterm.action.IncreaseFontSize,
	},
	{
		key = '0',
		mods = 'CTRL',
		action = wezterm.action.ResetFontSize,
	},
	{ key = 't', mods = 'SHIFT|CTRL', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
	-- { key = 'w', mods = 'SHIFT|CTRL', action = wezterm.action.CloseCurrentTab{ confirm = true } },
	-- run exit will close
}

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
	local zoomed = ''
  
	local active_pane = wezterm.mux.get_pane(tab.active_pane.pane_id)
	local domain_name = active_pane:get_domain_name()
  
	local index = ''
	if #tabs > 1 or domain_name == 'default' then
	  index = string.format('[%s][%d] ', active_pane:get_domain_name(), #tabs)
	end
  
	return index .. tab.active_pane.title
  end)

require("tab")
return config
