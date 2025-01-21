return {
  "EggbertFluffle/beepboop.nvim",
  enabled = false,
  opts = {
    audio_player = "afplay", -- Adjust this based on your OS (e.g., "paplay" for Linux, "afplay" for macOS)
    max_sounds = 20,
    sound_map = {
      -- Sounds for confirmations and back actions
      {
        auto_command = "InsertCharPre",
        sounds = {
          "back_style_2_001.wav",
          "confirm_style_2_001.wav",
        },
      },

      -- Sounds for error handling and confirmations
      {
        auto_command = "TextChanged",
        sounds = {
          "error_style_2_001.wav",
          "error_style_2_echo_001.wav",
        },
      },

      -- Sounds for cursor movement or interactions
      { auto_command = "CursorMoved", sounds = {
        "cursor_style_2.wav",
      } },

      {
        auto_command = "TextYankPost",
        sounds = {
          "back_style_2_echo_001.wav",
          "confirm_style_2_echo_001.wav",
        },
      },
    },
    sound_directory = "~/Downloads/ui", -- Adjust this path as needed
  },
}
