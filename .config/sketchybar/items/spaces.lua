local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local is_show_apps = true

-- Left padding
sbar.add("item", {
	icon = { drawing = false },
	label = { drawing = false },
	padding_left = 1,
})

local spaces = {}

for i = 1, 10, 1 do
	local space = sbar.add("space", "space." .. i, {
		space = i,
		icon = {
			font = { family = settings.font.numbers },
			string = i,
			padding_left = 15,
			padding_right = 8,
		},
		label = {
			padding_right = 20,
			color = colors.fg_secondary,
			highlight_color = colors.fg,
			font = "sketchybar-app-font:Regular:16.0",
			y_offset = -1,
		},
		padding_right = 1,
		padding_left = 1,
		background = {
			height = 26,
			border_color = colors.fg_highlight,
		},
	})

	spaces[i] = space

	-- Padding space
	sbar.add("space", "space.padding." .. i, {
		space = i,
		background = {
			drawing = false,
		},
		script = "",
		width = settings.group_paddings,
	})

	local space_popup = sbar.add("item", {
		position = "popup." .. space.name,
		padding_left = 5,
		padding_right = 0,
		background = {
			drawing = true,
			image = {
				corner_radius = 9,
				scale = 0.2,
			},
		},
	})

	space:subscribe("space_change", function(env)
		local selected = env.SELECTED == "true"
		space:set({
			icon = { highlight = selected },
			label = { highlight = selected },
			background = { border_width = selected and 2 or 0 },
		})
	end)

	space:subscribe("mouse.clicked", function(env)
		if env.BUTTON == "other" then
			space_popup:set({ background = { image = "space." .. env.SID } })
			space:set({ popup = { drawing = "toggle" } })
		else
			local op = (env.BUTTON == "right") and "--destroy" or "--focus"
			sbar.exec("yabai -m space " .. op .. " " .. env.SID)
		end

		is_show_apps = not is_show_apps

		sbar.animate("tanh", 10, function()
			if is_show_apps then
				space:set({ icon = { padding_right = 8 }, label = { width = "dynamic" } })
			else
				space:set({ icon = { padding_right = 15 }, label = { width = 0 } })
			end
		end)
	end)

	space:subscribe("mouse.entered", function(_)
		sbar.animate("tanh", 10, function()
			space:set({
				icon = {
					string = is_show_apps and icons.chevron.left or icons.chevron.right,
				},
			})
		end)
	end)

	space:subscribe("mouse.exited", function(_)
		sbar.animate("tanh", 10, function()
			space:set({
				icon = {
					string = i,
				},
			})
		end)
	end)
end

local space_window_observer = sbar.add("item", {
	drawing = false,
	updates = true,
})

space_window_observer:subscribe("space_windows_change", function(env)
	local icon_line = ""
	local no_app = true
	for app, count in pairs(env.INFO.apps) do
		no_app = false
		local lookup = app_icons[app]
		local icon = ((lookup == nil) and app_icons["default"] or lookup)
		icon_line = icon_line .. " " .. icon
	end

	if no_app then
		icon_line = " —"
	end
	sbar.animate("tanh", 10, function()
		spaces[env.INFO.space]:set({ label = icon_line })
	end)
end)
