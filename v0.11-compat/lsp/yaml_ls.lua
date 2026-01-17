--- @type vim.lsp.Config
return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yml" },
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
}
