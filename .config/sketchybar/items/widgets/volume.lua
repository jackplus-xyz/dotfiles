local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local popup_width = 250

local volume = sbar.add("item", "widgets.volume", {
	position = "right",
	icon = {
		string = icons.volume._100,
	},
	label = {
		string = "??%",
		font = { family = settings.font.numbers },
		width = 0,
	},
})

-- local volume_bracket = sbar.add("bracket", "widgets.volume.bracket", {
-- 	volume.name,
-- }, {
-- 	popup = { align = "center", background = {
-- 		corner_radius = 12,
-- 	} },
-- })

-- sbar.add("item", "widgets.volume.padding", {
-- 	position = "right",
-- 	width = settings.group_paddings,
-- })
--
-- local volume_slider = sbar.add("slider", popup_width, {
-- 	position = "popup." .. volume_bracket.name,
-- 	slider = {
-- 		highlight_color = colors.fg_highlight,
-- 		background = {
-- 			height = 6,
-- 			corner_radius = 3,
-- 			color = colors.bg2,
-- 		},
-- 		knob = {
-- 			string = "􀀁",
-- 			drawing = true,
-- 		},
-- 	},
-- 	click_script = 'osascript -e "set volume output volume $PERCENTAGE"',
-- })

volume:subscribe("volume_change", function(env)
	local vol = tonumber(env.INFO)
	local icon = icons.volume._0
	if vol > 60 then
		icon = icons.volume._100
	elseif vol > 30 then
		icon = icons.volume._66
	elseif vol > 10 then
		icon = icons.volume._33
	elseif vol > 0 then
		icon = icons.volume._10
	end

	local lead = ""
	if vol < 10 then
		lead = "0"
	end

	volume:set({
		icon = { string = icon },
		label = { string = lead .. vol .. "%" },
	})
	-- volume_slider:set({ slider = { percentage = vol } })
end)

-- local function volume_collapse_details()
-- 	local drawing = volume_bracket:query().popup.drawing == "on"
-- 	if not drawing then
-- 		return
-- 	end
-- 	volume_bracket:set({ popup = { drawing = false } })
-- 	sbar.remove("/volume.device\\.*/")
-- end

local current_audio_device = "None"
-- local function volume_toggle_details(env)
-- 	if env.BUTTON == "right" then
-- 		sbar.exec("open /System/Library/PreferencePanes/Sound.prefpane")
-- 		return
-- 	end
--
-- 	local should_draw = volume_bracket:query().popup.drawing == "off"
-- 	if should_draw then
-- 		volume_bracket:set({ popup = { drawing = true } })
-- 		sbar.exec("SwitchAudioSource -t output -c", function(result)
-- 			current_audio_device = result:sub(1, -2)
-- 			sbar.exec("SwitchAudioSource -a -t output", function(available)
-- 				local current = current_audio_device
-- 				local counter = 0
-- 				local selected = false
--
-- 				for device in string.gmatch(available, "[^\r\n]+") do
-- 					if current == device then
-- 						selected = true
-- 					end
-- 					sbar.add("item", "volume.device." .. counter, {
-- 						position = "popup." .. volume_bracket.name,
-- 						width = popup_width,
-- 						align = "center",
-- 						label = { string = device, highlight = selected },
-- 						click_script = 'SwitchAudioSource -s "'
-- 							.. device
-- 							.. '" && sketchybar --set /volume.device\\.*/ label.color='
-- 							.. colors.grey
-- 							.. " --set $NAME label.color="
-- 							.. colors.white,
-- 					})
-- 					counter = counter + 1
-- 				end
-- 			end)
-- 		end)
-- 	else
-- 		volume_collapse_details()
-- 	end
-- end

-- local function volume_scroll(env)
-- 	local delta = env.SCROLL_DELTA
-- 	sbar.exec('osascript -e "set volume output volume (output volume of (get volume settings) + ' .. delta .. ')"')
-- end

-- volume:subscribe("mouse.clicked", volume_toggle_details)
volume:subscribe("mouse.entered", function()
	sbar.animate("tanh", 30, function()
		volume:set({
			label = { width = "dynamic" },
		})
	end)
end)

volume:subscribe("mouse.exited", function()
	sbar.animate("tanh", 30, function()
		volume:set({
			label = { width = 0 },
		})
	end)
end)
-- volume:subscribe("mouse.scrolled", volume_scroll)
-- volume:subscribe("mouse.exited.global", volume_collapse_details)
