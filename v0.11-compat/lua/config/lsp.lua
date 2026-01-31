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

vim.lsp.enable({
	"lua_ls",
	"astro_ls",
	"go_ls",
	"docker_ls",
	"yaml_ls",
	"ts_ls",
})

vim.diagnostic.config({
	underline = true,
	virtual_text = true,
	-- virtual_lines = true, -- Slightly annoying when virtual_text is also enabled.
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
	update_in_insert = false,
	severity_sort = true,
	jump = {
		float = true,
		wrap = true,
	},
})
