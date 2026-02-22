--- https://go.dev/gopls/
--- @type vim.lsp.Config
return {
	cmd = { "gopls" },

	filetypes = { "go", "gomod", "gowork", "gosum" },

	root_markers = { "go.mod", "go.work", ".git" },

	settings = {
		gopls = {
			gofumpt = true,
			analyses = {
				unusedparams = true,
				unusedvariable = true,
			},
			codelenses = {
				generate = true,
				test = true,
				tidy = true,
			},
			semanticTokens = true,
			staticcheck = true,
			usePlaceholders = true,
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
}
