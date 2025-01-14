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
      model = "claude-3.5-sonnet",
      question_header = "  User ",
      answer_header = "  Copilot ",
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
}
