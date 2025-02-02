return {
  {
    -- <leader>mp: preview markdown files in browser
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    -- <A-hjkl> navigate between kitty windows and Neovim windows
    "mrjones2014/smart-splits.nvim",
    build = "./kitty/install-kittens.bash",
  },
}
