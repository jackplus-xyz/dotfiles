return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      render_modes = { "n", "v", "i", "c" },
      heading = {
        sign = false,
        position = "inline",
        backgrounds = { "ColorColumn" },
        foregrounds = { "RenderMarkdownH1" },
      },
      code = {
        sign = false,
        width = "block",
        left_pad = 2,
        right_pad = 4,
      },
      indent = { enabled = true },
    },
    ft = { "markdown", "norg", "rmd", "org" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
  },
}
