local blink = require("blink.cmp")
local on_attach = require("config.globals")

return {
	on_attach = on_attach,

	-- Command to start the HTML language server
	-- The schema lists 'vscode-html-language-server' as the executable
	cmd = { "vscode-html-language-server", "--stdio" },

	-- Filetypes to attach this LSP to
	filetypes = { "html" },

	-- Project root markers
	root_markers = { "package.json", ".git" },

	-- Settings based on the schema you provided
	settings = {
		html = {
			-- Enable/disable auto-closing of tags
			autoClosingTags = true,

			-- Enable/disable auto-creation of quotes
			autoCreateQuotes = true,

			-- Completion settings
			completion = {
				attributeDefaultValue = "doublequotes",
			},

			-- Formatting settings
			format = {
				enable = true,
				wrapLineLength = 120,
				preserveNewLines = true,
				-- A list of tags that should not be reformatted
				unformatted = "pre,code,textarea,wbr",
			},

			-- Hover settings
			hover = {
				documentation = true,
				references = true,
			},

			-- Enable HTML5 tag suggestions
			suggest = {
				html5 = true,
			},

			-- Validation settings
			validate = {
				scripts = true,
				styles = true,
			},
		},
	},

	-- Capabilities, extended with your 'blink' setup
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink.get_lsp_capabilities()
	),
}
