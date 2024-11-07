local icons = require("icons")
local colors = require("colors")
local TODO_FILE = "/tmp/sketchy_todo.txt"

local function loadTodoFromFile()
	local file = io.open(TODO_FILE, "r")
	if file then
		local todo = file:read("*a")
		file:close()
		return todo:match("^%s*(.-)%s*$") -- Trim any whitespace
	end
	return nil
end

local function saveTodoToFile(todo)
	local file = io.open("/tmp/sketchy_todo.txt", "w")
	if file then
		file:write(todo)
		file:close()
	end
end

local current_todo = loadTodoFromFile()

local is_entering = false

local todo = sbar.add("item", {
	position = "right",
	icon = { string = icons.todo.icon },
	label = { width = 0 },
	background = { color = colors.with_alpha(colors.bg, 0.0) },
	popup = {
		align = "center",
		horizontal = true,
	},
})

local new_todo_button = sbar.add("item", {
	position = "popup." .. todo.name,
	icon = { string = icons.todo.new },
	label = { drawing = false },
})

local check_todo_button = sbar.add("item", {
	position = "popup." .. todo.name,
	icon = { string = icons.todo.check },
	label = { drawing = false },
})

local function newTodo()
	if is_entering then
		sbar.exec("afplay /System/Library/Sounds/Tink.aiff")
		return
	end

	sbar.exec("afplay /System/Library/Sounds/Pop.aiff")
	is_entering = true

	local input_cmd =
		[[osascript -e 'Tell application "System Events" to display dialog "Enter TODO:" default answer ""' -e 'text returned of result']]

	sbar.exec(input_cmd, function(result)
		-- Remove any trailing newline from the input
		local new_todo = result:gsub("%s+$", "")
		is_entering = false

		if new_todo ~= "" then
			current_todo = new_todo
			sbar.exec("afplay /System/Library/Sounds/Purr.aiff")
			saveTodoToFile(new_todo)

			sbar.animate("tanh", 10, function()
				todo:set({
					label = {
						string = current_todo,
						width = "dynamic",
					},
					popup = {
						drawing = false, -- Hide popup after input
					},
				})
			end)
		end
	end)
end

local function checkTodo()
	if not current_todo or is_entering then
		sbar.exec("afplay /System/Library/Sounds/Tink.aiff")
		return
	end

	sbar.exec("afplay /System/Library/Sounds/Glass.aiff")
	current_todo = nil
	local rm_cmd = "rm " .. TODO_FILE
	sbar.exec(rm_cmd)
	sbar.animate("tanh", 10, function()
		todo:set({
			label = {
				width = 0,
			},
		})
	end)
end

new_todo_button:subscribe("mouse.clicked", newTodo)
check_todo_button:subscribe("mouse.clicked", checkTodo)

local popup_buttons = { new_todo_button, check_todo_button }
for _, popup_button in pairs(popup_buttons) do
	popup_button:subscribe("mouse.entered", function()
		popup_button:set({
			icon = { highlight = true },
		})
	end)
	popup_button:subscribe("mouse.exited", function()
		popup_button:set({
			icon = { highlight = false },
		})
	end)
end

todo:subscribe("mouse.entered", function()
	sbar.animate("tanh", 10, function()
		todo:set({
			background = {
				color = colors.with_alpha(colors.bg, 1.0),
				border_color = colors.with_alpha(colors.border, 1.0),
			},
		})
	end)
end)

todo:subscribe("mouse.exited.global", function()
	sbar.animate("tanh", 10, function()
		todo:set({
			background = {
				color = colors.with_alpha(colors.bg, 0.0),
				border_color = colors.with_alpha(colors.border, 0.0),
			},
			popup = {
				drawing = false,
			},
		})
	end)
end)

todo:subscribe("mouse.clicked", function()
	todo:set({
		popup = {
			drawing = "toggle",
		},
	})
end)

-- Initial load: If SKETCHY_TODO is set, display it
if current_todo then
	sbar.animate("tanh", 10, function()
		todo:set({
			label = {
				string = current_todo,
				width = "dynamic",
			},
		})
	end)
end
