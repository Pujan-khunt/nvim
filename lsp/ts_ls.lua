local blink = require("blink.cmp")
local on_attach = require("config.globals")

return {
	on_attach = on_attach,
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	settings = {
		typescript = {
			tsserver = {
				useSyntaxServer = false,
			},
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			autoClosingTags = true,
			preferGoToSourceDefinition = true,
			referencesCodeLens = {
				enabled = true,
				showOnAllFunctions = true,
			},
			suggestionActions = {
				enabled = true,
			},
			updateImportsOnFileMove = {
				enabled = true,
			},
			updateImportsOnPaste = {
				enabled = true,
			},
			validate = {
				enabled = true,
			},
			hover = {
				maximumLength = 500,
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
