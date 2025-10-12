local blink = require("blink.cmp")
local on_attach = require("config.globals")

return {
	-- The on_attach function to be executed when the LSP attaches to a buffer.
	on_attach = on_attach,

	cmd = { "docker-language-server", "start", "--stdio" },

	filetypes = { "dockerfile", "yaml", "dockerbake", "hcl" },

	root_markers = { "Dockerfile", "docker-compose.yml", "docker-compose.yaml", "bake.hcl", ".git" },

	-- Initialization options sent to the server on startup.
	-- This replaces the incorrect 'settings' table from the previous version.
	init_options = {
		-- Telemetry can be set to "all", "error", or "off".
		-- "off" is a good default for privacy.
		telemetry = "off",

		dockercomposeExperimental = {
			-- Compose file support is enabled by default.
			composeSupport = true,
		},

		dockerfileExperimental = {
			-- Set to true if you also use 'rcjsuen/dockerfile-language-server'
			-- to avoid duplicate diagnostic messages.
			removeOverlappingIssues = false,
		},
	},

	-- LSP capabilities, extended with your custom `blink` capabilities.
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink.get_lsp_capabilities()
		-- OPTIONAL: Add experimental capabilities for Bake file code lens.
		-- To enable this, you must also define a client-side command named
		-- 'dockerLspClient.bake.build' that can execute the build.
		-- {
		--   experimental = {
		--     dockerLanguageServerCapabilities = {
		--       commands = {
		--         "dockerLspClient.bake.build",
		--       },
		--     },
		--   },
		-- }
	),
}
