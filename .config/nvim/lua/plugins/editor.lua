return {
  {
    -- sort & hide tailwind classes
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = {
      "jsx",
      "js",
      "ts",
      "tsx",
    },
    opts = {
      document_color = {
        enabled = false,
        kind = "foreground",
      },
      conceal = {
        enabled = false,
        symbol = "~",
      },
    },
  },
  {
    -- <leader>mp: preview markdown files in browser
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    -- terminal file manager
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>yf",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>yy",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      -- {
      -- NOTE: this requires a version of yazi that includes
      -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
      -- "<c-up>",
      -- "<cmd>Yazi toggle<cr>",
      -- desc = "Resume the last yazi session",
      -- },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,

      -- enable these if you are using the latest version of yazi
      -- use_ya_for_events_reading = true,
      -- use_yazi_client_id_flag = true,

      -- keymaps = {
      --   show_help = "<f1>",
      -- },
    },
  },
  -- Don't bring up neotree when opening a directory
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        hijack_netrw_behavior = "disabled",
      },
    },
  },
  {
    --A simple Neovim plugin to build games with LÖVE
    "S1M0N38/love2d.nvim",
    lazy = true,
    ft = "lua",
    cmd = "LoveRun",
    opts = {},
    keys = {
      { "<leader>v", ft = "lua", desc = "LÖVE" },
      { "<leader>vv", "<cmd>LoveRun<cr>", ft = "lua", desc = "Run LÖVE" },
      { "<leader>vs", "<cmd>LoveStop<cr>", ft = "lua", desc = "Stop LÖVE" },
    },
  },
  {
    -- Distraction-free coding for Neovim
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>zm", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
    },
  },
  {
    -- Smart, seamless, directional navigation and resizing of Neovim + terminal multiplexer splits. Supports tmux, Wezterm, and Kitty. Think about splits in terms of "up/down/left/right".
    "mrjones2014/smart-splits.nvim",
    build = "./kitty/install-kittens.bash",
  },
  {
    "folke/which-key.nvim",
    opts = {
      icons = { mappings = false }, -- hide the icons in `which-key`
    },
  },
}
