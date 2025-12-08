return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	opts = {
		ensure_installed = {
			"typescript",
			"svelte",
			"css",
			"html",
			"javascript",
			"tsx",
			"c",
			"cpp",
			"java",
			"lua",
			"python",
			"bash",
			"go",
			"json",
		},
		highlight = {
			enable = true,
		},
		incremental_selection = {
			enable = true,
		},
		indent = {
			enable = true,
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
