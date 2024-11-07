local colors = require("colors")
local settings = require("settings")
local icons = require("icons")

local workspace_item = sbar.add("item", "workspace_indicator", {
	drawing = false,
	position = "right",
	icon = {
		string = icons.aerospace,
		font = { size = 14.0 },
		padding_right = 8,
		padding_left = 8,
		color = colors.black,
	},
	label = {
		drawing = false,
	},
	background = {
		color = colors.transparent,
		border_width = 0,
	},
	padding_left = 1,
	padding_right = 1,
	updates = true,
})

-- Subscribe mode change event
workspace_item:subscribe("aerospace_mode_change", function(env)
	local focused_mode = env.MODE
	if focused_mode == "service" then
		workspace_item:set({
			drawing = true,
			icon = {
				color = colors.white,
			},
			label = {
				color = colors.white,
			},
			background = {
				color = colors.red,
				border_color = colors.white,
				border_width = 1,
			},
		})
	else
		workspace_item:set({
			drawing = false,
		})
	end
end)
