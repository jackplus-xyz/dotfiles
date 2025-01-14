return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      width = 48,
      preset = {
        header = [[Neovim]],
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
