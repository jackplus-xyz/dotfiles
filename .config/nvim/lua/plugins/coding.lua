return {
  {
    -- configures LuaLS for editing Neovim config by lazily updating your workspace libraries
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- You can add other libraries as needed
      },
      integrations = {
        -- Fixes lspconfig's workspace management for LuaLS
        lspconfig = true,
        -- Add the cmp source for completion of require statements and module annotations
        cmp = true,
      },
      -- Enable lazydev for all Lua files unless explicitly disabled
      enabled = function()
        return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
      end,
    },
  },
  { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
  {
    -- emulate the behaviour of the Cursor AI IDE
    "yetone/avante.nvim",
    enabled = true,
    event = "VeryLazy",
    build = "make", -- This is Optional, only if you want to use tiktoken_core to calculate tokens count
    opts = {
      provider = "copilot",
    },
    dependencies = {
      "echasnovski/mini.icons",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below is optional, make sure to setup it properly if you have lazy=true
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    -- fast and feature-rich surround actions
    "echasnovski/mini.surround",
    opts = {
      -- Overwrite the default keymaps of `gs` to `;`
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
    -- Overwrite the default keymaps to accomadate `mini.surround`
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
    -- Use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation.
    "chrisgrieser/nvim-spider",
    enabled = false,
    lazy = true,
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
    },
  },
}
