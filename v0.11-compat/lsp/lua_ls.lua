--- https://luals.github.io/wiki/settings/
--- @type vim.lsp.Config
return {
  -- Command and arguments to run the language server
  cmd = { "lua-language-server" },

  -- Filetypes in neovim to automatically attach to. To view the filetype, run :echo &filetype
  filetypes = { "lua" },

  -- Files that share the same root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority.
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },

  settings = {
    Lua = {
      codeLens = { enable = true },
      completion = {
        autoRequire = true, -- Auto require file/module when using its dependency
        callSnippet = "Both", -- Show snippet AND function name in completion
        displayContext = 10, -- Number of lines of the context window
        enable = true,
        keyWordSnippet = "Both", -- Show keyword AND snippet in completion
        postfix = "@", -- Character to trigger "postfix suggestions"
      },
      diagnostics = {
        disable = {}, -- Disable certain diagnostics globally
      },
      hint = { enable = true },
      runtime = { version = "LuaJIT" },
      -- Managed by ../lua/plugins/lazydev.lua
      -- workspace = {
      --   -- checkThirdParty = false,
      --   library = {
      --     -- Pulls the Neovim runtime directory at /usr/share/nvim/runtime/lua
      --     vim.env.VIMRUNTIME
      --   }
      -- },
    }
  },
}
