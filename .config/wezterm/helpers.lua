local wezterm = require("wezterm")
local M = {}

local appearance = wezterm.gui.get_appearance()

M.is_dark = function()
	return appearance:find("Dark")
end

M.get_conf_folder = function()
	local home = os.getenv("HOME") or os.getenv("USERPROFILE")
	local wezterm_conf_folder = "\\.config\\wezterm"
	return home .. wezterm_conf_folder
end

M.get_random_entry = function(tbl)
	local keys = {}
	for key, _ in ipairs(tbl) do
		table.insert(keys, key)
	end
	local randomKey = keys[math.random(1, #keys)]
	return tbl[randomKey]
end

--- M.get_background
-- @param dark (int) Represents the darkness level of the background.
-- @param light (int) Represents the lightness level of the background.
-- @return The computed background color.
M.get_background = function(dark, light)
	dark = dark or 0.8
	light = light or 0.8
	return {
		source = {
			Gradient = {
				colors = { M.is_dark() and "#000000" or "#ffffff" },
			},
		},
		width = "100%",
		height = "100%",
		opacity = M.is_dark() and dark or light,
	}
end

M.get_color_scheme = function()
	-- return get_color_scheme()
	return M.is_dark() and "Catppuccin Mocha" or "Catppuccin Latte"
end


M.get_randor_wallpaper = function(dir)
	local wallpapers = {}
	for _, v in ipairs(wezterm.glob(dir)) do
		if not string.match(v, "%.DS_Store$") then
			table.insert(wallpapers, v)
		end
	end
	local wallpaper = M.get_random_entry(wallpapers)
	return {
		source = { File = { path = wallpaper } },
		height = "Cover",
		width = "Cover",
		horizontal_align = "Center",
		repeat_x = "Repeat",
		repeat_y = "Repeat",
		opacity = 1,
		-- speed = 200,
	}
end

M.get_wallpaper_by_path = function(wallpaper_path)
	return {
		source = { File = { path = wallpaper_path } },
		height = "Cover",
		width = "Cover",
		horizontal_align = "Center",
		repeat_x = "Repeat",
		repeat_y = "Repeat",
		opacity = 1,
		-- speed = 200,
	}
end


M.generate_parallax_folder = function(folder)
	folder =  "\\" .. folder
	return M.get_conf_folder() .. '\\parallax\\' .. folder .. '\\'
end

M.generate_anim_folder = function(name)
	return M.get_conf_folder() .. '\\wallpapers\\' .. name .. '.gif'
end

return M
