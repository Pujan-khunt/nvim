local on_attach = require("config.globals")
local blink = require("blink.cmp")

return {
	on_attach = on_attach,
	filetypes = { "go" },
	root_markers = { ".git" },

	-- The command to start the language server.
	-- Neovim will find this in your PATH.
	cmd = { "gopls" },

	-- Settings specifically for gopls.
	-- You can find all options here:
	-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
	settings = {
		gopls = {
			-- Enables extra analyses for code diagnostics.
			analyses = {
				unusedparams = true,
			},
			-- This enables semantic tokens, which allows for more detailed syntax highlighting.
			ui = {
				semanticTokens = true,
			},
		},
	},

	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink.get_lsp_capabilities()
	),
}
