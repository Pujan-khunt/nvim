--- https://github.com/docker/docker-language-server
--- @type vim.lsp.Config
return {
	cmd = { "docker-language-server", "start", "--stdio" },

	filetypes = { "dockerfile", "docker-compose", "bake" },

	root_markers = {
		{ "docker-compose.yml", "docker-compose.yaml", "docker-compose.json" },
		{ "Dockerfile", "Dockerfile.dev", "Dockerfile.prod" },
		"docker-bake.hcl",
		".dockerignore",
		".git",
	},

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

	settings = {},
}
