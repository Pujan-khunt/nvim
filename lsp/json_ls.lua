-- File: lua/config/lsp/json_ls.lua

local blink = require("blink.cmp")
local on_attach = require("config.globals")

return {
	-- The command to start the JSON language server
	cmd = { "vscode-json-language-server", "--stdio" },

	-- Filetypes to attach to
	filetypes = { "json", "jsonc" },

	-- Custom on_attach function from your globals
	on_attach = on_attach,

	-- Root directory markers
	root_markers = { "package.json", ".git" },

	-- Language server settings
	settings = {
		json = {
			-- Schemas for validation and autocompletion
			schemas = {
				{
					fileMatch = { "package.json" },
					url = "https://json.schemastore.org/package.json",
				},
				{
					fileMatch = { "tsconfig.json", "jsconfig.json" },
					url = "https://json.schemastore.org/tsconfig.json",
				},
				{
					fileMatch = { ".prettierrc", ".prettierrc.json" },
					url = "https://json.schemastore.org/prettierrc.json",
				},
				{
					fileMatch = { ".eslintrc", ".eslintrc.json" },
					url = "https://json.schemastore.org/eslintrc.json",
				},
				{
					fileMatch = { "composer.json" },
					url = "https://json.schemastore.org/composer.json",
				},
				{
					fileMatch = { "biome.json" },
					url = "https://biomejs.dev/schemas/2.2.0/schema.json",
				},
			},
			-- Enable validation
			validate = {
				enable = true,
			},
			-- Enable formatting
			format = {
				enable = true,
			},
		},
	},

	-- Capabilities, extended with your custom 'blink' setup
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink.get_lsp_capabilities()
	),
}
