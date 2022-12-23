return {
  settings = {
    Lua = {
      diagnostics = {
        -- Injected symbols when file is used as an embedded language
        globals = { "awesome", "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
        maxPreload = 10000,
      },
    },
  },
}
