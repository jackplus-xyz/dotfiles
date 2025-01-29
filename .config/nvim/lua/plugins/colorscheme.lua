return {
  {
    "LazyVim/LazyVim",
    opts = function()
      return {
        -- colorscheme = "flexoki",
        -- colorscheme = "zenwritten",
        -- colorscheme = "mime",
      }
    end,
  },
  { "nuvic/flexoki-nvim", name = "flexoki" },
  { "catppuccin/nvim", enabled = false },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    -- enabled = false,
    opts = {
      style = "night",
      transparent = true,
      day_brightness = 0,
      styles = {
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
      },
      tab_size = 8,
    },
  },
  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    -- lazy = false,
    priority = 1000,
    config = function()
      vim.g.zenwritten_transparent_background = vim.g.neovide and false or true
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "zenwritten",
        callback = function()
          -- Zenwritten Tweaks
          local base_hls = require("zenwritten")

          local new_hls = {
            Constant = { fg = base_hls.Constant.fg.hex },
            Number = { fg = base_hls.Number.fg.hex },
            Boolean = { fg = base_hls.Boolean.fg.hex },
            SnacksDim = { fg = base_hls.Comment.fg.hex },
          }

          for hl, props in pairs(new_hls) do
            vim.api.nvim_set_hl(0, hl, props)
          end
        end,
      })
    end,
  },
  {
    -- Automatically switch between light and dark mode
    "f-person/auto-dark-mode.nvim",
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
}
