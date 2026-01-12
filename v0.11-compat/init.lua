require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

-- apply the colorscheme
vim.cmd("colorscheme cyberdream")

vim.lsp.enable({ "lua_ls", "astro_ls", "go_ls" })
