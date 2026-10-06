-- look.lua

local noctalia = require("noctalia")
local active_glow = noctalia.colors.primary:gsub("rgb", "rgba"):gsub("%)", "bb)")
local inactive_glow = noctalia.colors.secondary:gsub("rgb", "rgba"):gsub("%)", "66)")

hl.config({
	cursor = {
		no_hardware_cursors = 1,
	},
	decoration = {
		active_opacity = 0.9,
		blur = {
			enabled = true,
			passes = 2,
			size = 10,
			xray = false,
		},
		inactive_opacity = 0.9,
		rounding = 11,
		rounding_power = 3.0,
		shadow = {
			enabled = false,
		},
		glow = {
			enabled = true,
			range = 20,
			render_power = 5,
			color = active_glow,
			color_inactive = inactive_glow,
		},
	},
	ecosystem = {
		enforce_permissions = false,
	},
	general = {
		border_size = 0,
		col = {
			active_border = "0xffa8c8ff",
			inactive_border = "0xff111319",
		},
		gaps_in = 2,
		gaps_out = 8,
	},
	misc = {
		key_press_enables_dpms = true,
		mouse_move_enables_dpms = true,
	},
	xwayland = {
		force_zero_scaling = true,
	},
})

-- Smooth Animations
hl.animation({ leaf = "global", enabled = true, speed = 8.0, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 6.0, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 6.0, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 6.0, bezier = "default", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 10.0, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 6.0, bezier = "default" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 6.0, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 7.0, bezier = "default", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 7.0, bezier = "default", style = "slidefadevert 20%" })

-- For Noctalia Color templates
noctalia.apply_theme()
