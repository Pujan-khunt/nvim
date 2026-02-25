--- @module "lazy"
--- @type LazySpec
return {
	"kdheepak/lazygit.nvim",
	lazy = true,
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<C-A-j>",
			"<cmd>LazyGit<CR>",
			mode = { "n", "t" },
			desc = "Toggle Lazygit",
		},
		{
			"<C-A-f>",
			"<cmd>LazyGitFilterCurrentFile<CR>",
			mode = { "n", "t" },
			desc = "Lazygit Current File",
		},
	},
}
