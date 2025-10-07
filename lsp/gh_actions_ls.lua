local on_attach = require("config.globals")
local blink = require("blink.cmp")

return {
	on_attach = on_attach,
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink.get_lsp_capabilities()
	),

	cmd = { "gh-actions-language-server", "--stdio" },
	filetypes = { "yaml" },
	root_markers = { ".git" },

	init_options = {
		sessionToken = "",
	},
}
