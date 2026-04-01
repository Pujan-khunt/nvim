--- @module "lazy"
--- @type LazySpec
return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
		},
	},
	opts = {
		ensure_installed = {
			"astro",
			"ts_ls",
			"dockerls",
			"gopls",
			"lua_ls",
			"yamlls",
			"jdtls",
			"buf_ls",
			"tailwindcss",
			"clangd",
			"pylsp",
		},

		automatic_enable = {
			exclude = { "lua_ls", "jdtls" },
		},
	},
}
