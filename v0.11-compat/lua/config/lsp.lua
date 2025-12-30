vim.lsp.config["lua_ls"] = {
  -- Command and arguments to run the language server
  cmd = { "lua-language-server" },

  -- Filetypes in neovim to automatically attach to. To view the filetype, run :echo &filetype
  filetypes = { "lua" },


  -- Files that share the same root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority.
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },

  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { global = { "vim" } },
    }
  }
}

vim.lsp.enable("lua_ls")
