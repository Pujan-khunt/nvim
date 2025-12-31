require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

require("utils.notifier")

-- apply the colorscheme
vim.cmd("colorscheme cyberdream")

vim.lsp.enable("lua_ls")
