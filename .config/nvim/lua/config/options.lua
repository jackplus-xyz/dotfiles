-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.laststatus = 0
opt.wrap = false
opt.linebreak = false
opt.cursorline = false

vim.g.snacks_animate = false

if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  -- BEHAVIOR
  vim.g.neovide_theme = "auto"
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_remember_window_size = true
  -- UI
  vim.g.neovide_padding_top = 16
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 8
  vim.g.neovide_padding_left = 8
  -- ANIMATION
  vim.g.neovide_position_animation_length = 0.1
  vim.g.neovide_scroll_animation_length = 0.05
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.4
end
