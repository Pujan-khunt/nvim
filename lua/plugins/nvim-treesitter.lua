return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	opts = {
		ensure_installed = {
			"html",
			"javascript",
			"typescript",
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
	-- config = function(_, opts)
	-- 	require("nvim-treesitter.configs").setup(opts)
	-- end,
}
