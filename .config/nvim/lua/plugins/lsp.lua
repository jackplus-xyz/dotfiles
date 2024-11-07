return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using
                version = "LuaJIT",
              },
              diagnostics = {
                -- Get the language server to recognize the `love` global
                globals = { "vim", "love" },
                -- disable = { "lowercase-global" },
              },
            },
          },
        },
      },
    },
  },
}
