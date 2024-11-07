local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
	updates = "when_shown",
	icon = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = 14.0,
		},
		color = colors.fg,
		highlight_color = colors.fg_highlight,
		padding_left = settings.icon.padding_left,
		padding_right = settings.icon.padding_right,
		background = { image = { corner_radius = 12 } },
	},
	label = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = 12.0,
		},
		color = colors.fg,
		highlight_color = colors.fg_highlight,
		padding_left = settings.label.padding_left,
		padding_right = settings.label.padding_right,
	},
	background = {
		color = colors.bg,
		height = 28,
		corner_radius = 12,
		border_width = 0,
		border_color = colors.border,
		image = {
			corner_radius = 12,
			border_color = colors.border,
			border_width = 2,
		},
	},
	popup = {
		background = {
			border_width = 2,
			corner_radius = 9999,
			color = colors.bg,
			border_color = colors.border,
			shadow = { drawing = true },
		},
		height = 28,
		blur_radius = 50,
	},
	padding_left = 4,
	padding_right = 4,
	scroll_texts = true,
})
