local on_attach = require("config.globals")
local blink = require("blink.cmp")

return {
	on_attach = on_attach,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	-- Find the root of the project by looking for go.work, go.mod, or a .git directory.
	root_markers = { "go.work", "go.mod", ".git" },
	settings = {
		gopls = {
			-- Set to true to use gofumpt for formatting. This is the primary requirement.
			-- gofumpt is a stricter formatter than gofmt and is generally preferred.
			gofumpt = true,

			-- Enable various code lenses to provide contextual actions in your code.
			codelenses = {
				generate = true, -- Shows a lens for running 'go generate'.
				gc_details = true, -- Shows details about garbage collection for benchmarks.
				test = true, -- Shows a lens for running tests and benchmarks.
				tidy = true, -- Shows a lens for running 'go mod tidy'.
			},

			-- Inlay hints provide extra information in your code, like parameter names and types.
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},

			-- Enable staticcheck for advanced static analysis.
			staticcheck = true,

			-- Additional analyses to improve code quality.
			analyses = {
				unusedwrite = true, -- Checks for unused writes to struct fields.
				shadow = true, -- Checks for shadowed variables.
			},

			-- Use placeholders for function parameters upon completion, which you can then tab through.
			-- usePlacelers = true,

			-- Add build tags if your project uses them. This is a common setup.
			buildFlags = { "-tags=integration" },

			-- Enable experimental postfix completions, like `foo.if` to generate `if foo { ... }`.
			experimentalPostfixCompletions = true,
		},
	},
	-- Extend the default LSP capabilities with those from your completion plugin (blink/cmp).
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink.get_lsp_capabilities()
	),
}
