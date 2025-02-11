return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      model = "claude-3.5-sonnet",
      question_header = "[>] ",
      answer_header = "< ",
      auto_insert_mode = false,
      show_help = false,
      contexts = {
        file = {
          input = function(callback)
            local fzf = require("fzf-lua")
            local fzf_path = require("fzf-lua.path")
            fzf.files({
              complete = function(selected, opts)
                local file = fzf_path.entry_to_file(selected[1], opts, opts._uri)
                if file.path == "none" then
                  return
                end
                vim.defer_fn(function()
                  callback(file.path)
                end, 100)
              end,
            })
          end,
        },
      },
    },
    keys = {
      {
        "<leader>am",
        "<Cmd>CopilotChatModels<CR>",
        desc = "Select Models (CopilotChat)",
      },
      {
        "<leader>ac",
        "<Cmd>CopilotChatCommit<CR>",
        desc = "Write Commit Message (CopilotChat)",
      },
    },
  },
  {
    -- Overwrite the default keymaps of `gs` to `;`
    "echasnovski/mini.surround",
    dependencies = {
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
}
