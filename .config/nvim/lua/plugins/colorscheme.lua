return {
  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    config = function()
      vim.g.noirbones_transparent_background = true
    end,
  },
  -- Automatically switch between light and dark mode using darkvoid
  {
    "f-person/auto-dark-mode.nvim",
    enabled = true,
    config = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.cmd("set background=dark")
      end,
      set_light_mode = function()
        vim.cmd("set background=light")
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "noirbones",
    },
  },
}
