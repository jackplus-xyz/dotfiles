return {
  {
    "jackplus-xyz/scroll-it.nvim",
    -- enabled = false,
    -- dev = true,
    dir = "~/Developer/projects/scroll-it.nvim",
    lazy = false,
    opts = {
      enabled = true,
      -- reversed = true,
      -- overlap_lines = 4,
      hide_line_number = "all",
    },
    keys = {
      {
        "<leader>ms",
        "<cmd>ScrollItToggle<cr>",
        desc = "Toggle Scroll It",
      },
    },
  },
  {
    "jackplus-xyz/binary.nvim",
    dev = false,
    dir = "~/Developer/projects/binary.nvim",
    opts = {
      colors = {
        -- bg = "#ffb400",
        fg = "#1B1B1B",
        bg = "#EBEBEB",
      },
      reversed_group = {
        DiffAdd = true,
        DiffDelete = true,
        DiffText = true,
      },
    },
  },
  {
    "jeackpls-xyz/monaspace.nvim",
    enabled = false,
    dir = "~/Developer/projects/monaspace.nvim",
    dev = true,
    lazy = false,
    opts = {
      -- use_default = false,
      -- style_map = {
      --   italic = {
      --     Comment = true,
      --   },
      --   bold_italic = {},
      -- },
    },
  },
  {
    "jackplus-xyz/campfire.nvim",
    enabled = false,
    dev = true,
    dir = "~/Developer/projects/campfire.nvim",
    -- lazy = false,
    config = function()
      require("campfire").setup()
    end,
    -- opts = {},
  },
}
