## Plugin Specification for Lazy

Each file under $XDG_CONFIG_DIR/nvim/lua/plugins should satisfy the plugin specification.
Source: https://lazy.folke.io/spec

## Dependencies you need to install in your system for neovim to function correctly.
- ripgrep (telescope, live_grep)
- fd (telescope, picker)
- tree-sitter-cli (nvim-treesitter, compiling parsers)
- cargo (blink, compiling)
- rustup (blink, compiling)
- opencode (opencode.nvim)
- lua-language-server (lua lsp)
- @astrojs/language-server {download from the npm registry} (astro lsp)
- gopls {go install golang.org/x/tools/gopls} (go lsp)
- lazygit
- jdtls {https://download.eclipse.org/jdtls/milestones/?d} (java lsp)

### Java language server
- Make sure to set the path of `jdtls` in the `lsp/java_ls.lua` file.

### Astro language server
To use formatting via the astro language server, you will need 2 packages locally installed in your project.
- prettier
- prettier-plugin-astro
