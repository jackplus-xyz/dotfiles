local icons = require("icons")
local colors = require("colors")

local whitelist = { ["Spotify"] = true, ["Music"] = true }

local media_icon = sbar.add("item", {
	-- position = "right",
	icon = {
		string = icons.music,
		color = colors.fg,
	},
	label = {
		width = 0,
		color = colors.fg,
	},
	background = {
		color = colors.with_alpha(colors.bg, 0.0),
		border_color = colors.with_alpha(colors.border, 0.0),
		border_width = 2,
		image = {
			drawing = false,
			scale = 0.85,
		},
	},
	drawing = false,
	updates = true,
	popup = {
		align = "center",
		horizontal = true,
	},
})

-- Combine media_artist and media_title into one item
local media_info = sbar.add("item", {
	drawing = false,
	icon = { drawing = false },
	label = {
		font = { size = 12 },
		color = colors.with_alpha(colors.fg, 1),
		width = 0,
		max_chars = 35, -- Adjust the max characters to fit both artist and title
		padding_left = 10,
		padding_right = 10,
	},
	background = {
		color = colors.with_alpha(colors.bg, 0.0),
		border_color = colors.with_alpha(colors.border, 0.0),
	},
})

local back_icon = sbar.add("item", {
	position = "popup." .. media_icon.name, -- Use media_icon for positioning
	icon = { string = icons.media.back, font = { size = 12.0 } },
	label = { drawing = false },
	click_script = "nowplaying-cli previous",
})
local pause_icon = sbar.add("item", {
	position = "popup." .. media_icon.name,
	icon = { string = icons.media.play_pause, font = { size = 12.0 } },
	label = { drawing = false },
	click_script = "nowplaying-cli togglePlayPause",
})
local forward_icon = sbar.add("item", {
	position = "popup." .. media_icon.name,
	icon = { string = icons.media.forward, font = { size = 12.0 } },
	label = { drawing = false },
	click_script = "nowplaying-cli next",
})

local interrupt = 0
local function animate_detail(detail)
	if not detail then
		interrupt = interrupt - 1
	end
	if interrupt > 0 and not detail then
		return
	end

	sbar.animate("tanh", 30, function()
		media_info:set({ label = { width = detail and "dynamic" or 0 } })
	end)
end

-- Media change event subscription
media_icon:subscribe("media_change", function(env)
	if whitelist[env.INFO.app] then
		local drawing = (env.INFO.state == "playing")
		local artist_title = env.INFO.artist .. " - " .. env.INFO.title -- Concatenate artist and title
		media_info:set({ drawing = drawing, label = artist_title })
		media_icon:set({ drawing = drawing })

		if drawing then
			animate_detail(true)
			interrupt = interrupt + 1
			sbar.delay(5, animate_detail)
		else
			media_icon:set({ popup = { drawing = false } })
		end
	end
end)

media_icon:subscribe("mouse.entered", function(env)
	interrupt = interrupt + 1
	animate_detail(true)
	sbar.animate("tanh", 10, function()
		media_icon:set({
			icon = {
				color = {
					alpha = 0,
				},
			},
			background = {
				color = { alpha = 0.0 },
				border_color = { alpha = 0.0 },
				image = {
					drawing = true,
					string = "media.artwork",
					scale = 0.85,
				},
			},
		})
		media_info:set({
			label = {
				color = { alpha = 1 },
			},
			background = {
				color = { alpha = 1 },
				border_color = { alpha = 1 },
			},
		})
	end)
end)

media_icon:subscribe("mouse.exited", function(env)
	animate_detail(false)
	sbar.animate("tanh", 30, function()
		media_icon:set({
			icon = {
				color = colors.fg,
			},
			background = {
				image = {
					drawing = false,
				},
				color = { alpha = 0.0 },
				border_color = { alpha = 0.0 },
			},
		})
		media_info:set({
			label = {
				color = colors.fg,
			},
			background = {
				color = { alpha = 0 },
				border_color = { alpha = 0 },
			},
		})
	end)
end)

media_icon:subscribe("mouse.clicked", function(env)
	media_icon:set({ popup = { drawing = "toggle" } })
end)

media_info:subscribe("mouse.exited.global", function(env)
	media_icon:set({ popup = { drawing = false } })
end)

back_icon:subscribe("mouse.entered", function()
	back_icon:set({ icon = { highlight = true } })
end)
pause_icon:subscribe("mouse.entered", function()
	pause_icon:set({ icon = { highlight = true } })
end)
forward_icon:subscribe("mouse.entered", function()
	forward_icon:set({ icon = { highlight = true } })
end)

back_icon:subscribe("mouse.exited", function()
	back_icon:set({ icon = { highlight = false } })
end)
pause_icon:subscribe("mouse.exited", function()
	pause_icon:set({ icon = { highlight = false } })
end)
forward_icon:subscribe("mouse.exited", function()
	forward_icon:set({ icon = { highlight = false } })
end)
