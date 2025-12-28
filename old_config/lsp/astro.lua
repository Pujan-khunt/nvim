local blink = require("blink.cmp")
local on_attach = require("config.globals")

return {
	on_attach = on_attach,
	-- The command to start the Astro language server
	cmd = { "astro-ls", "--stdio" },

	-- Filetypes to attach to
	filetypes = { "astro" },

	-- Root directory markers
	root_markers = {
		"astro.config.mjs",
		"astro.config.js",
		"astro.config.ts",
		"astro.config.cjs",
		"package.json",
		".git",
	},

	settings = {
		astro = {
			-- TypeScript integration settings
			typescript = {
				enable = true,
				diagnostics = { enable = true },
			},
			-- Content intellisense
			content = {
				intellisense = true,
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
