return {
  -- generate gitignore file
  -- Usage: `:Gitignore [path]`
  {
    "wintermute-cell/gitignore.nvim",
    config = function()
      require("gitignore")
    end,
  },
}
