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
				gc_details = true,
				test = true,
				tidy = true,
			},
			completeUnimported = true,
			semanticTokens = true,
			staticcheck = true,
			usePlaceholders = true,
		},
	},
}
