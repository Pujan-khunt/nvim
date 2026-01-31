--- https://github.com/typescript-language-server/typescript-language-server
--- @type vim.lsp.Config
return {
	-- Command to run the language server
	cmd = { "typescript-language-server", "--stdio" },

	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},

	-- Prioritize specific project config files, then fall back to git
	root_markers = {
		{ "tsconfig.json", "jsconfig.json", "package.json" },
		".git",
	},

	-- Settings migrated from your old config
	settings = {
		typescript = {
			autoClosingTags = true,
			enablePromptUseWorkspaceTsdk = true,
			preferGoToSourceDefinition = true,
			reportStyleCheckAsWarnings = true,

			-- Code Lenses
			implementationsCodeLens = {
				enabled = true,
				showOnAllFunctions = true,
				showOnInterfaceMethods = true,
			},
			referencesCodeLens = {
				enabled = true,
				showOnAllFunctions = true,
			},

			-- Import & Code Preferences
			preferences = {
				organizeImports = true,
				renameMatchingJsxTags = true,
				importModuleSpecifier = "relative",
				quoteStyle = "double",
				jsxAttributeCompletionStyle = "auto",
			},

			-- Inlay Hints
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
				parameterNames = { enabled = true },
				parameterTypes = { enabled = true },
			},

			-- Formatting (disabled in favor of Conform/Prettier/Biome)
			format = {
				enable = false,
			},
		},

		-- Same settings for JavaScript
		javascript = {
			autoClosingTags = true,
			preferGoToSourceDefinition = true,
			suggestionActions = { enabled = true },
			updateImportsOnFileMove = { enabled = true },
			updateImportsOnPaste = { enabled = true },

			referencesCodeLens = {
				enabled = true,
				showOnAllFunctions = true,
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
				parameterNames = { enabled = true },
				parameterTypes = { enabled = true },
			},

			format = {
				enable = false,
			},
		},
	},
}
