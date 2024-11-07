local is_dark_mode = require("is_dark_mode") == "dark"

local colors = {}
local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end
colors.with_alpha = with_alpha

local theme = {
	-- Base16 Default Dark Theme
	dark = 0xff181818,
	dark_grey = 0xff282828,
	grey = 0xff383838,
	light_grey = 0xff585858,
	dark_silver = 0xffb8b8b8,
	silver = 0xffd8d8d8,
	light_silver = 0xffe8e8e8,
	light = 0xfff8f8f8,
	red = 0xffab4642,
	orange = 0xffdc9656,
	yellow = 0xfff7ca88,
	green = 0xffa1b56c,
	cyan = 0xff86c1b9,
	blue = 0xff7cafc2,
	magenta = 0xffba8baf,
	brown = 0xffa16946,

	-- Special colors
	transparent = 0x00000000,
	black = 0xff000000,
	white = 0xffffffff,
	github_blue = 0xff4170ae,
}

for k, v in pairs(theme) do
	colors[k] = v
end

if is_dark_mode then
	colors.fg = theme.silver
	colors.fg_highlight = theme.blue
	colors.fg_secondary = theme.silver
	colors.bg = theme.black
	colors.border = theme.dark
	colors.active = theme.white
else
	colors.fg = theme.dark
	colors.fg_highlight = theme.github_blue
	colors.fg_secondary = theme.light_grey
	colors.bg = theme.light
	colors.border = theme.silver
	colors.active = theme.white
end

return colors
