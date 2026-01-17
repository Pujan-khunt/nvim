--- https://github.com/rcjsuen/dockerfile-language-server
--- @type vim.lsp.Config
return {
	cmd = { "docker-langserver", "--stdio" },

	filetypes = { "dockerfile", "docker-compose", "bake" },

	root_markers = {
		{ "docker-compose.yml", "docker-compose.yaml", "docker-compose.json" },
		{ "Dockerfile", "Dockerfile.dev", "Dockerfile.prod" },
		"docker-bake.hcl",
		".dockerignore",
		".git",
	},

	settings = {},
}
