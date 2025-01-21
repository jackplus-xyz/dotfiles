return {
  {
    -- Overwrite the default keymaps of `gs` to `;`
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = ";;",
        delete = ";d",
        find = ";f",
        find_left = ";F",
        highlight = ";h",
        replace = ";r",
        update_n_lines = ";n",
      },
      custom_surroundings = {
        ["B"] = {
          input = { "%[%[().-()%]%]" },
          output = { left = "**", right = "**" },
        },
        ["C"] = {
          input = { "%[%[().-()%]%]" },
          output = { left = "```\n", right = "\n```" },
        },
        ["L"] = {
          input = { "%[%[().-()%]%]" },
          output = { left = "```lua\n", right = "\n```" },
        },
      },
    },
  },
  {
    -- overwrite the default keymaps to accomadate `mini.surround`
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          keys = { "f", "F", "t", "T" },
        },
      },
    },
  },
  {
    -- use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation.
    "chrisgrieser/nvim-spider",
    enabled = false,
    lazy = true,
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    -- enabled = false,
    opts = {
      -- model = "claude-3.5-sonnet",
      question_header = "[>] ",
      answer_header = "< ",
      auto_insert_mode = false,
      auto_follow_cursor = true,
      show_help = false,
    },
  },
  {
    "saghen/blink.cmp",
    -- enabled = false,
    -- dev = true,
    dir = "~/.local/share/nvim/lazy/blink.cmp",
    opts = {
      -- signature = { enabled = false },
    },
  },
  {
    "yetone/avante.nvim",
    enabled = false,
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    -- dependencies = {
    --   "stevearc/dressing.nvim",
    --   "nvim-lua/plenary.nvim",
    --   "MunifTanjim/nui.nvim",
    --   --- The below dependencies are optional,
    --   "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    --   "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    --   "zbirenbaum/copilot.lua", -- for providers='copilot'
    --   {
    --     -- support for image pasting
    --     "HakonHarnes/img-clip.nvim",
    --     event = "VeryLazy",
    --     opts = {
    --       -- recommended settings
    --       default = {
    --         embed_image_as_base64 = false,
    --         prompt_for_file_name = false,
    --         drag_and_drop = {
    --           insert_mode = true,
    --         },
    --         -- required for Windows users
    --         use_absolute_path = true,
    --       },
    --     },
    --   },
    --   {
    --     -- Make sure to set this up properly if you have lazy=true
    --     "MeanderingProgrammer/render-markdown.nvim",
    --     opts = {
    --       file_types = { "markdown", "Avante" },
    --     },
    --     ft = { "markdown", "Avante" },
    --   },
    -- },
  },
}
