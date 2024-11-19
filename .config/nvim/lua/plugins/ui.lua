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
    enabled = false,
  },
  {
    "echasnovski/mini.statusline",
    version = "*",
    event = "VeryLazy",
    config = function()
      local MiniStatusline = require("mini.statusline")
      MiniStatusline.setup({
        use_icons = true,
        content = {
          active = function()
            local diag_signs = { ERROR = " ", WARN = " ", INFO = "' ", HINT = " " }
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git = MiniStatusline.section_git({ trunc_width = 40 })
            local diff = MiniStatusline.section_diff({ trunc_width = 75 })
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75, icon = "", signs = diag_signs })
            local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
            local filename = MiniStatusline.section_filename({ trunc_width = 9999 })
            local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })

            local function section_location()
              local cursor_line = vim.fn.line(".")
              local total_lines = vim.fn.line("$")
              local percentage = math.floor((cursor_line / total_lines) * 100)
              return string.format("%d%%%% %d:%d", percentage, cursor_line, total_lines)
            end

            -- Use it in place of `MiniStatusline.section_location`
            local location_section = section_location()
            return MiniStatusline.combine_groups({
              -- { hl = mode_hl, strings = { mode } },
              {
                -- hl = "MiniStatuslineDevinfo",
                strings = {
                  git,
                  diff,
                  diagnostics,
                  lsp,
                },
              },
              "%<", -- Mark general truncate point
              {
                hl = "MiniStatuslineFilename",
                strings = { filename },
              },
              "%=", -- End left alignment
              -- { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
              { strings = { location_section } },
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
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      dashboard = {
        enabled = true,
        width = 18,
        preset = {
          -- stylua: ignore
          keys = {
            { icon = "", key = "f", desc = " ̲find file", action = ":lua Snacks.dashboard.pick('files')", },
            { icon = "", key = "n", desc = " ̲new file", action = ":ene | startinsert" },
            { icon = "", key = "g", desc = " ̲grep text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = "", key = "r", desc = " ̲recent file", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = "", key = "c", desc = " ̲config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
            { icon = "", key = "s", desc = " ̲session", section = "session" },
            { icon = "", key = "L", desc= " ̲Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = "", key = "q", desc = " ̲quit", action = ":qa" },
          },
          header = [[
                                                                   
      ████ ██████           █████      ██                 btw
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
]],
        },

        formats = {
          key = { "" },
        },
      },
    },
  },
}
