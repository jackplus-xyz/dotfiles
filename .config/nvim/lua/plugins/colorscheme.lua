local theme_config = require("config.theme_config")
local light_theme = "base16-tomorrow"
local dark_theme = "base16-default-dark"

return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- Initial setup
      colorscheme = theme_config.is_dark_mode and dark_theme or light_theme,
    },
  },

  -- automatic switch between light and dark mode
  {
    "f-person/auto-dark-mode.nvim",
    priority = 1000,
    -- Add colorschemes to use here
    dependencies = {
      "RRethy/base16-nvim",
    },
    config = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.cmd("colorscheme " .. dark_theme)
      end,
      set_light_mode = function()
        vim.cmd("colorscheme " .. light_theme)
      end,
    },
  },
}
