-- ~/.config/nvim/lua/plugins/lsp/servers/yaml_ls.lua

local on_attach = require("config.globals")
-- Assuming you have a 'blink.cmp' module for capabilities, like in your example.
-- If not, you can remove this line and the `blink.get_lsp_capabilities()` call below.
local blink = require("blink.cmp")

return {
	on_attach = on_attach,
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yml" },
	-- You can add more specific root markers if needed, e.g., "docker-compose.yml"
	root_markers = { ".git" },
	settings = {
		yaml = {
			-- Enables schema suggestions from https://www.schemastore.org/json/
			schemaStore = {
				enable = true,
				url = "https://www.schemastore.org/api/json/catalog.json",
			},
			-- Configure validation, completion, and hover features.
			validate = true,
			completion = true,
			hover = true,
			-- Custom schemas for specific file patterns.
			-- This is very useful for projects with custom YAML structures.
			schemas = {
				kubernetes = "/*.k8s.yaml",
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/*docker-compose*.{yml,yaml}",
				["https://json.schemastore.org/lefthook.json"] = "/lefthook.{yml,yaml}",
			},
			-- Formatting options for the YAML files.
			format = {
				enable = true,
				printWidth = 120, -- Max line length
				singleQuote = false, -- Use double quotes for strings
				bracketSpacing = true,
			},
		},
	},
	-- This merges Neovim's default capabilities with any from your completion plugin.
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink.get_lsp_capabilities()
	),
}
