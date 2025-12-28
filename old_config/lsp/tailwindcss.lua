local blink = require("blink.cmp")
local on_attach = require("config.globals")

return {
	on_attach = on_attach,
	-- The command to start the Tailwind CSS language server
	cmd = { "tailwindcss-language-server", "--stdio" },

	-- Filetypes where Tailwind classes should trigger the LSP
	filetypes = {
		"html",
		"css",
		"scss",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"svelte",
		"vue",
		"postcss",
	},

	-- Markers to detect the project root
	root_markers = {
		"tailwind.config.js",
		"tailwind.config.ts",
		"tailwind.config.cjs",
		"postcss.config.js",
		".git",
	},

	-- Server-specific settings
	settings = {
		tailwindCSS = {
			classAttributes = { "class", "className", "classList", "ngClass" },
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidScreen = "error",
				invalidVariant = "error",
				recommendedVariantOrder = "warning",
			},
			validate = true,
			-- Enable experimental class sorting if you want consistency
			-- experimental = {
			--   classRegex = {
			--     { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
			--     { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" }
			--   },
			-- },
		},
	},

	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink.get_lsp_capabilities()
	),
}
