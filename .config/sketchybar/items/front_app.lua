local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local front_app = sbar.add("item", "front_app", {
	display = "active",
	icon = {
		font = "sketchybar-app-font:Regular:16.0",
	},
	updates = true,
})

front_app:subscribe("front_app_switched", function(env)
	local lookup = app_icons[env.INFO]
	local icon = ((lookup == nil) and app_icons["default"] or lookup)
	front_app:set({
		icon = "" .. icon,
		label = { string = env.INFO },
	})
end)
