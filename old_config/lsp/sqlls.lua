local blink = require("blink.cmp")
local on_attach = require("config.globals")

return {
	-- The on_attach function is inherited from your global configuration, just like in the TypeScript setup.
	on_attach = on_attach,

	-- Specifies the command to start the SQL language server.
	cmd = { "sql-language-server", "up", "--method", "stdio" },

	-- This language server will attach to files with the "sql" filetype.
	filetypes = { "sql" },

	-- Defines how the LSP determines the root directory of your project.
	-- In this case, it looks for any .sql file.
	root_markers = { "*.sql" },

	-- Server-specific settings. You can configure database connections and linter rules here.
	settings = {
		sqlLanguageServer = {
			-- connections = [],
			lint = {},
		},
	},

	-- Merges Neovim's default LSP capabilities with any additional ones provided by other plugins, like 'blink'.
	-- This structure is identical to your TypeScript configuration.
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink.get_lsp_capabilities()
	),
}
