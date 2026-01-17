require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

-- apply the colorscheme
vim.cmd("colorscheme cyberdream")

--- @type vim.lsp.Config
local globalConfig = {
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		require("blink.cmp").get_lsp_capabilities()
	),
}
vim.lsp.config("*", globalConfig)

vim.lsp.enable({ "lua_ls", "astro_ls", "go_ls", "docker_ls" })
