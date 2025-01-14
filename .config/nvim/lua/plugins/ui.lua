return {
  {
    -- buffer line
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "center",
          },
        },
      },
    },
  },
  {
    -- disabled LazyVim default statusline
    "nvim-lualine/lualine.nvim",
    -- enabled = false,
    -- opts = function()
    --   return {
    --     options = {
    --       component_separators = { left = "", right = "" },
    --       section_separators = { left = "", right = "" },
    --     },
    --   }
    -- end,
  },
  {
    "echasnovski/mini.statusline",
    enabled = false,
    version = "*",
    event = "VeryLazy",
    dependencies = {
      {
        "lewis6991/gitsigns.nvim",
        enabled = true,
      },
    },
    config = function()
      local MiniStatusline = require("mini.statusline")
      MiniStatusline.setup({
        use_icons = true,
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git = MiniStatusline.section_git({ trunc_width = 75 })
            local diff = MiniStatusline.section_diff({ trunc_width = 120 })
            local diag_signs = { ERROR = " ", WARN = " ", INFO = " ", HINT = " " }
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75, icon = "", signs = diag_signs })
            local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
            local filename = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location = MiniStatusline.section_location({ trunc_width = 120 })
            local search = MiniStatusline.section_searchcount({ trunc_width = 120 })

            return MiniStatusline.combine_groups({
              { hl = mode_hl, strings = { mode } },
              { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
              "%<", -- Mark general truncate point
              { hl = "MiniStatuslineFilename", strings = { filename } },
              "%=", -- End left alignment
              { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
              { hl = mode_hl, strings = { search, location } },
            })
          end,
          inactive = function()
            local filename = MiniStatusline.section_filename({ trunc_width = 9999 })

            return MiniStatusline.combine_groups({
              { hl = "MiniStatuslineFilename", strings = { filename } },
            })
          end,
        },
      })
      -- Hide statusline at startup
      vim.o.laststatus = 0

      vim.api.nvim_create_autocmd("BufRead", {
        pattern = "*",
        callback = function()
          -- Show the statusline when a file is read
          vim.o.laststatus = 2
        end,
      })
    end,
  },
}
