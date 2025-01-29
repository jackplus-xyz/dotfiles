-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local del = vim.keymap.del

-- jk: escape
map("i", "jk", "<esc>", { noremap = true, silent = true })

-- <leader>mp: toggle makrdown preview
map(
  "n",
  "<leader>mp",
  "<cmd>MarkdownPreview<cr>",
  { desc = "Open Markdown Preview in Browser", noremap = true, silent = true }
)

-- <leader>mf: Run current Lua file
map("n", "<leader>mf", function()
  if vim.bo.filetype ~= "lua" then
    vim.notify("Not a Lua file", vim.log.levels.WARN)
    return
  end
  vim.cmd("source %")
  vim.notify("Sourced " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
end, { desc = "Run current Lua file", noremap = true, silent = true })

-- <leader>mt: Test current Lua file
map("n", "<leader>mt", function()
  if vim.bo.filetype ~= "lua" then
    vim.notify("Not a Lua file", vim.log.levels.WARN)
    return
  end
  vim.cmd("PlenaryBustedFile %")
end, { desc = "Test current Lua file", noremap = true, silent = true })

-- remove default mappings
del("n", "<C-h>")
del("n", "<C-j>")
del("n", "<C-k>")
del("n", "<C-l>")

-- <alt> + hjkl: navigate between windows(nvim windows and kitty windows)
local function try_smart_split_or_vim(vim_cmd, smart_splits_func)
  -- Get the current window number
  local current_win = vim.api.nvim_get_current_win()

  -- Try to navigate to the window using the vim command
  vim.api.nvim_command(vim_cmd)

  -- Check if the window changed
  local new_win = vim.api.nvim_get_current_win()

  -- If the window hasn't changed, use the smart splits function
  if current_win == new_win then
    smart_splits_func()
  end
end
-- Update key mappings to use the fixed function
-- stylua: ignore start
map("n", "<A-h>", function() try_smart_split_or_vim("wincmd h", require("smart-splits").move_cursor_left) end, { desc = "Go to left window or try smart-split", remap = true })
map("n", "<A-j>", function() try_smart_split_or_vim("wincmd j", require("smart-splits").move_cursor_down) end, { desc = "Go to lower window or try smart-split", remap = true })
map("n", "<A-k>", function() try_smart_split_or_vim("wincmd k", require("smart-splits").move_cursor_up) end, { desc = "Go to upper window or try smart-split", remap = true })
map("n", "<A-l>", function() try_smart_split_or_vim("wincmd l", require("smart-splits").move_cursor_right) end, { desc = "Go to right window or try smart-split", remap = true })
-- stylua: ignore end

-- <leader>tc: toggle Tailwind CSS classes conceal
map("n", "<leader>tc", "<cmd>TailwindConcealToggle<cr>", { noremap = true, silent = true })

-- vA: select entire bugger
map("n", "<leader>vA", "ggVG", { desc = "Select entire buffer" })

-- get the comment string
local function get_comment_string()
  local ft = vim.bo.filetype
  local commentstring = vim.bo.commentstring
  if commentstring and commentstring ~= "" then
    return commentstring:gsub("%%s", "")
  elseif ft == "lua" then
    return "-- "
  elseif ft == "python" or ft == "sh" then
    return "# "
  else
    return "// "
  end
end

-- yA: yank entire buffer with commented file path
map("n", "<leader>yA", function()
  local file_path = vim.fn.expand("%:.")
  local comment_string = get_comment_string()

  -- Save the current cursor position
  local current_pos = vim.api.nvim_win_get_cursor(0)

  vim.cmd("normal! ggVGy")

  local yanked_text = vim.fn.getreg('"')

  -- Prepend the commented file path to the yanked text
  local final_text = comment_string .. file_path .. "\n" .. yanked_text

  -- Set the registers with the modified text
  vim.fn.setreg("+", final_text)
  vim.fn.setreg('"', final_text)

  -- Restore the cursor to its original position
  vim.api.nvim_win_set_cursor(0, current_pos)

  print("Yanked to clipboard with commented file path: " .. file_path)
end, { desc = "Yank entire buffer with commented file path" })

-- yF: yank entire buffer without file path
map("n", "<leader>yF", function()
  -- Save the current cursor position
  local current_pos = vim.api.nvim_win_get_cursor(0)

  vim.cmd("normal! ggVGy")

  local yanked_text = vim.fn.getreg('"')

  -- Set the registers with the yanked text (no modification)
  vim.fn.setreg("+", yanked_text)
  vim.fn.setreg('"', yanked_text)

  -- Restore the cursor to its original position
  vim.api.nvim_win_set_cursor(0, current_pos)

  print("Yanked entire buffer to clipboard")
end, { desc = "Yank entire buffer without file path" })

-- yX: yank entire buffer with file path and diagnostics
map("n", "<leader>yX", function()
  local file_path = vim.fn.expand("%:.")

  -- Save the current cursor position
  local current_pos = vim.api.nvim_win_get_cursor(0)

  -- Use the default 'y' command to yank the entire buffer
  vim.cmd("normal! ggVGy")

  -- Get the yanked text from the unnamed register
  local yanked_text = vim.fn.getreg('"')

  -- Get diagnostics using vim.diagnostic.get()
  local diagnostics = vim.diagnostic.get(0)
  local diagnostic_messages = {}

  for _, diagnostic in ipairs(diagnostics) do
    local severity = vim.diagnostic.severity[diagnostic.severity]
    local message = string.format("Line %d (%s): %s", diagnostic.lnum + 1, severity, diagnostic.message)
    table.insert(diagnostic_messages, message)
  end

  local final_text = file_path
    .. "\n"
    .. yanked_text
    .. "\n\n"
    .. "Diagnostics:\n"
    .. table.concat(diagnostic_messages, "\n")

  vim.fn.setreg("+", final_text)
  vim.fn.setreg('"', final_text)

  -- Restore the cursor to its original position
  vim.api.nvim_win_set_cursor(0, current_pos)

  print("Yanked to clipboard with file path and diagnostics: " .. file_path)
end, { desc = "Yank entire buffer with file path and diagnostics" })
