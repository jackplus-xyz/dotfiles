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
      {
        "<leader>vl",
        "<cmd>!rm -rf /tmp/love.log && love . > /tmp/love.log<cr>",
        ft = "lua",
        desc = "Run LÖVE with logging",
      },
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
  -- {
  --   "ibhagwan/fzf-lua",
  --   opts = {
  --     files = {
  --       git_icons = false,
  --       file_icons = false,
  --       actions = {
  --         ["alt-g"] = { require("fzf-lua").actions.toggle_ignore },
  --         ["alt-h"] = { require("fzf-lua").actions.toggle_hidden },
  --       },
  --     },
  --     -- fzf_colors = false,
  --     winopts = {
  --       border = "single",
  --       preview = {
  --         border = "single",
  --         scrollbar = false,
  --       },
  --     },
  --   },
  -- },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    opts = {
      default_component_configs = {
        modified = {
          symbol = "[+]",
          highlight = "NeoTreeModified",
        },
        indent = {
          expander_collapsed = ">",
          expander_expanded = "",
          with_markers = false,
        },
        name = {
          trailing_slash = true,
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
          end,
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = "",
          highlight = "Normal",
        },
        git_status = {
          symbols = {
            added = "+",
            modified = "*",
            deleted = "-",
            renamed = ">",
            untracked = "?",
            ignored = "!",
            unstaged = "~",
            staged = "=",
            conflict = "x",
          },
        },
      },
    },
  },
  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      -- {
      --   "<leader>-",
      --   mode = { "n", "v" },
      --   "<cmd>Yazi<cr>",
      --   desc = "Open yazi at the current file",
      -- },
      {
        -- Open in the current working directory
        "<leader>e",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      -- {
      --   -- NOTE: this requires a version of yazi that includes
      --   -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
      --   "<c-up>",
      --   "<cmd>Yazi toggle<cr>",
      --   desc = "Resume the last yazi session",
      -- },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      -- keymaps = {
      --   show_help = "<f1>",
      -- },
    },
  },
}
