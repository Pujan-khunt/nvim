return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	opts = {
		ensure_installed = {
			"javascript",
			"typescript",
			"c",
			"cpp",
			"java",
			"lua",
			"python",
			"bash",
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
