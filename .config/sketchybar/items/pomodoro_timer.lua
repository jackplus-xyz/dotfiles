local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local pomodoro_duration = 25 * 60
local break_duration = 5 * 60
local long_break_duration = 15 * 60
local session_count = 1
local max_session_count = 4

local remaining_time = pomodoro_duration
local is_pomodoro = true
local is_running = false

local function format_time(seconds)
	local minutes = math.floor(seconds / 60)
	local secs = seconds % 60
	return string.format("%02d:%02d", minutes, secs)
end

local pomodoro_timer = sbar.add("item", {
	position = "right",
	icon = { string = icons.timer },
	label = { font = { family = settings.font.numbers }, width = 0 },
	background = {
		color = colors.with_alpha(colors.bg, 0.0),
		border_width = 0,
	},
	updates = true,
	update_freq = 1, -- Runs the timer function every second
	popup = {
		align = "center",
		horizontal = true,
	},
})

local function start_timer()
	is_running = true
	sbar.exec("afplay /System/Library/Sounds/Funk.aiff")
end

local function stop_timer()
	is_running = false
	sbar.exec("afplay /System/Library/Sounds/Bottle.aiff")
end

local pause_session_icon = sbar.add("item", {
	position = "popup." .. pomodoro_timer.name,
	icon = { string = icons.media.play },
	label = { drawing = false },
})

local function start_stop_timer()
	sbar.animate("tanh", 10, function()
		if is_running then
			pause_session_icon:set({ icon = { string = icons.media.play } })
			pomodoro_timer:set({
				icon = { color = colors.fg },
				label = { color = colors.fg },
				background = { color = colors.bg },
			})
			stop_timer()
		else
			pause_session_icon:set({ icon = { string = icons.media.pause } })
			start_timer()
		end
	end)
end

local function next_session()
	start_stop_timer()
	if is_pomodoro then
		if session_count >= max_session_count then
			session_count = 1
			remaining_time = long_break_duration
		else
			remaining_time = break_duration
		end
	else
		session_count = session_count + 1
		remaining_time = pomodoro_duration
	end

	pomodoro_timer:set({
		label = { string = format_time(remaining_time) },
	})

	is_pomodoro = not is_pomodoro
end

local function timer()
	local icon_color = colors.fg
	local bg_color = colors.with_alpha(colors.bg, 0)
	local label_color = colors.fg
	local border_width = 0

	if is_running then
		label_color = colors.active
		icon_color = colors.active

		if remaining_time > 0 then
			remaining_time = remaining_time - 1
		elseif remaining_time == 0 then
			-- Play the sound when a pomodoro session is completed
			if is_pomodoro then
				sbar.exec("afplay /System/Library/Sounds/Glass.aiff")
			end
			next_session()
			pomodoro_timer:set({ popup = { drawing = true } })
		end

		pomodoro_timer:set({
			label = {
				string = format_time(remaining_time),
			},
		})

		if is_pomodoro then
			bg_color = colors.with_alpha(colors.orange, 1)
			border_width = 2
		else
			bg_color = colors.with_alpha(colors.green, 1)
			border_width = 2
		end

		sbar.animate("tanh", 10, function()
			pomodoro_timer:set({
				icon = {
					color = icon_color,
				},
				label = {
					color = label_color,
				},
				background = {
					color = bg_color,
					border_width = border_width,
				},
			})
		end)
	end
end

local reset_session_icon = sbar.add("item", {
	position = "popup." .. pomodoro_timer.name,
	icon = { string = icons.media.reset },
	label = { drawing = false },
})

local skip_session_icon = sbar.add("item", {
	position = "popup." .. pomodoro_timer.name,
	icon = { string = icons.media.skip },
	label = { drawing = false },
})

local function reset_session()
	stop_timer()
	session_count = 1
	is_pomodoro = true
	remaining_time = pomodoro_duration
	pomodoro_timer:set({
		label = {
			string = format_time(remaining_time),
			width = "dynamic",
			color = colors.fg,
		},
		icon = {
			color = colors.fg,
		},
		background = {
			color = colors.bg,
		},
	})
	pause_session_icon:set({
		icon = { string = icons.media.play },
	})
end

local function reset_timer()
	reset_session_icon:set({ icon = { highlight = true } })
	sbar.delay(1, function()
		reset_session_icon:set({ icon = { highlight = false } })
	end)
	reset_session()
end

local function skip_timer()
	skip_session_icon:set({ icon = { highlight = true } })
	sbar.delay(1, function()
		skip_session_icon:set({ icon = { highlight = false } })
	end)
	next_session()
	if is_running then
		stop_timer()
	end
end

local function show_timer()
	sbar.animate("tanh", 10, function()
		pomodoro_timer:set({
			label = {
				string = format_time(remaining_time),
				width = "dynamic",
			},
			background = {
				color = { alpha = 1 },
			},
		})
		pause_session_icon:set({
			icon = { string = is_running and icons.media.pause or icons.media.play },
		})
	end)
end

local function toggle_popup()
	pomodoro_timer:set({
		popup = {
			drawing = "toggle",
		},
	})
	pause_session_icon:set({
		icon = { string = is_running and icons.media.pause or icons.media.play },
	})
end

local function hide_timer()
	sbar.animate("tanh", 10, function()
		pomodoro_timer:set({
			label = { width = 0 },
		})

		if not is_running then
			pomodoro_timer:set({
				background = {
					color = { alpha = 0 },
					border_width = 0,
				},
			})
		end
	end)
end

pomodoro_timer:subscribe("mouse.clicked", function(env)
	if env.BUTTON == "left" then
		toggle_popup()
	elseif env.BUTTON == "right" then
		if is_running then
			next_session()
		else
			start_timer()
		end
	end
end)

pomodoro_timer:subscribe("routine", timer)

pomodoro_timer:subscribe("mouse.entered", show_timer)
reset_session_icon:subscribe("mouse.clicked", reset_timer)
pause_session_icon:subscribe("mouse.clicked", start_stop_timer)
skip_session_icon:subscribe("mouse.clicked", skip_timer)

reset_session_icon:subscribe("mouse.entered", function()
	reset_session_icon:set({ icon = { highlight = true } })
end)
pause_session_icon:subscribe("mouse.entered", function()
	pause_session_icon:set({ icon = { highlight = true } })
end)
skip_session_icon:subscribe("mouse.entered", function()
	skip_session_icon:set({ icon = { highlight = true } })
end)

reset_session_icon:subscribe("mouse.exited", function()
	reset_session_icon:set({ icon = { highlight = false } })
end)
pause_session_icon:subscribe("mouse.exited", function()
	pause_session_icon:set({ icon = { highlight = false } })
end)
skip_session_icon:subscribe("mouse.exited", function()
	skip_session_icon:set({ icon = { highlight = false } })
end)

pomodoro_timer:subscribe("mouse.exited.global", function()
	hide_timer()
	pomodoro_timer:set({ popup = { drawing = false } })
end)
