return {
  {
    "jackplus-xyz/scroll-it.nvim",
    -- enabled = false,
    dev = true,
    dir = "~/Developer/projects/scroll-it.nvim",
    lazy = false,
    opts = {
      -- enabled = true,
      -- reversed = true,
      overlap_lines = 4,
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
    enabled = false,
    -- dev = true,
    -- dir = "~/Developer/projects/binary.nvim",
    -- lazy = false,
    priority = 1000,
    -- opts = {
    --   colors = {
    --     -- fg = "#ff0000",
    --     -- bg = "#ffb400",
    --     -- fg = "#191919",
    --     -- bg = "#EBEBEB",
    --     -- fg = "#0E1F12",
    --     -- bg = "#2CF180",
    --     -- fg = "#1F4382",
    --     -- bg = "#60D9FE",
    --     fg = "#2CF180",
    --     bg = "#0E1F12",
    --   },
    --   -- use_default_reversed_group = false,
    --   reversed_group = {
    --     -- ["@lsp.type.comment"] = true,
    --     DiffAdd = true,
    --     DiffDelete = true,
    --     DiffText = true,
    --     Cursor = false,
    --   },
    -- },
  },
  {
    "jackpls-xyz/monaspace.nvim",
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
    -- Archived and successed by `player-one.nvim`
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
  {
    "jackplus-xyz/player-one.nvim",
    dev = true,
    dir = "~/Developer/projects/player-one.nvim",
    -- lazy = true,
    -- enabled = false,
    dependencies = {
      -- {
      --   "saghen/blink.cmp",
      --   enabled = false,
      -- },
      {
        "nvim-lua/plenary.nvim",
        lazy = false,
      },
    },
    opts = {},
  },
}
