return {
  --[[ AI ]]
  { import = "lazyvim.plugins.extras.ai.copilot-chat" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    -- enabled = false,
    opts = {
      model = "claude-3.5-sonnet",
      question_header = "[>] ",
      answer_header = "< ",
      auto_insert_mode = false,
      show_help = false,
    },
    keys = {
      {
        "<leader>am",
        "<Cmd><CR>",
        desc = "Select Models (CopilotChat)",
      },
    },
  },
  --[[ CODING ]]
  { import = "lazyvim.plugins.extras.coding.blink" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
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
  { import = "lazyvim.plugins.extras.coding.yanky" },
  --[[ EDITOR ]]
  { import = "lazyvim.plugins.extras.editor.dial" },
  { import = "lazyvim.plugins.extras.editor.fzf" },
  { import = "lazyvim.plugins.extras.editor.snacks_explorer" },
  { import = "lazyvim.plugins.extras.editor.snacks_picker" },
  -- { import = "lazyvim.plugins.extras.editor.inc-rename" },
  { import = "lazyvim.plugins.extras.editor.mini-diff" },
  --[[ UI ]]
  { import = "lazyvim.plugins.extras.ui.treesitter-context" },
  --[[ UTILS ]]
  { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
  --[[ LANGUAGES ]]
  { import = "lazyvim.plugins.extras.lang.clangd" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.svelte" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
}
