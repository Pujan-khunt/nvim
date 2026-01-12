--- https://go.dev/gopls/
--- @type vim.lsp.Config
return {
	cmd = { "gopls" },

	filetypes = { "go", "gomod", "gowork", "gosum" },

	root_markers = { "go.mod", "go.work", ".git" },

	settings = {
		gopls = {
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
		},
	},
}
