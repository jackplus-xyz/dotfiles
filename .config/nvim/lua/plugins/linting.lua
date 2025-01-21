local HOME = os.getenv("HOME")
return {
  -- disable some markdownlint rules
  "mfussenegger/nvim-lint",
  enabled = false,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", HOME .. "/.config/nvim/lua/plugins/.markdownlint-cli2.yaml", "--" },
      },
    },
  },
}
