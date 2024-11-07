local icons = require("icons")
local settings = require("settings")

local mail = sbar.add("item", {
	drawing = false,
	position = "right",
	icon = { string = icons.mail.unread },
	label = { font = { family = settings.font.numbers }, width = 0 },
	updates = true,
	update_freq = 60,
})

local function is_unread_mails()
	sbar.exec([[osascript -e 'tell application "Mail" to get the unread count of inbox']], function(unread_mails)
		local count = tonumber(unread_mails)
		if count >= 1 then
			mail:set({
				drawing = true,
				label = tostring(count),
			})
		else
			mail:set({
				drawing = false,
			})
		end
	end)
end

mail:subscribe("routine", is_unread_mails)

mail:subscribe("mouse.clicked", function()
	sbar.exec("open -a 'Mail'")
end)
