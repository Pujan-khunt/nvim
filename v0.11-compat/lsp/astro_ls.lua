--- https://github.com/withastro/language-tools/tree/main/packages/language-server
--- @type vim.lsp.Config
return {
	-- Command and arguments to run the Astro language server
	cmd = { "astro-ls", "--stdio" },

	-- Filetypes in neovim to automatically attach to
	filetypes = { "astro" },

	-- Files that share the same root directory will reuse the LSP server connection
	-- Nested lists indicate equal priority
	root_markers = {
		{ "astro.config.mjs", "astro.config.js", "astro.config.ts", "astro.config.cjs" },
		".git",
	},

	settings = {
		astro = {
			-- TypeScript integration settings
			typescript = {
				enable = true,
				diagnostics = {
					enable = true,
					-- Enable comprehensive TypeScript diagnostics
					complainAboutReturnType = true,
					complainAboutUndefinedVars = true,
				},
			},

			-- Content intellisense for better completion
			content = {
				intellisense = true,
			},

			-- ESLint integration for code quality
			eslint = {
				enable = true,
				diagnostics = { enable = true },
			},

			-- Tailwind CSS integration for class completion
			tailwindcss = {
				enable = true,
				-- Enable class name completion and suggestions
				classCompletion = true,
				-- Show color previews for Tailwind classes
				colorPreview = true,
			},
		},
	},

	-- Initialization options for the language server
	init_options = {
		typescript = {
			-- TypeScript specific initialization
			maxTsServerMemory = 4096,
			-- Point to local TypeScript installation in node_modules
			-- This is preferred because it ensures version consistency with the project
			tsdk = vim.fn.finddir("node_modules/typescript/lib", vim.fn.getcwd() .. ";"),
		},
	},

	-- Enhanced completion settings
	completion = {
		enable = true,
		-- Show function signatures in completion
		signatureHelp = true,
		-- Auto-complete with snippets
		snippetSupport = true,
	},

	-- Diagnostic configuration
	diagnostics = {
		-- Enable all diagnostic capabilities
		enable = true,
		-- Show diagnostic signs in the gutter
		signs = true,
		-- Update diagnostics as you type
		updateInInsert = false,
		-- Virtual text for diagnostics
		virtual_text = {
			enable = true,
			prefix = "■",
		},
	},
}
