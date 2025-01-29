return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      width = 48,
      preset = {
        header = [[Neovim]],
        keys = {
          { icon = "", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = "", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = "", key = "g", desc = "Grep Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = "", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = "",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = "", key = "s", desc = "Restore Session", section = "session" },
          { icon = "", key = "x", desc = "Lazy extras", action = ":LazyExtras" },
          { icon = "", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = "", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      formats = {
        key = { "" },
      },
    },
    scroll = {
      animate = {
        easing = "inQuad",
        duration = { step = 15, total = 100 },
      },
    },
    profiler = {
      enabled = false,
    },
  },
}
