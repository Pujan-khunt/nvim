--- @module "lazy"
--- @type LazySpec
return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitDir",
		"LazyGitFilter",
		"LazyGitFetch",
	},
	keys = {
		{ "<C-g>", "<cmd>LazyGit<CR>", mode = { "n", "t" }, desc = "Open Lazygit" },
	},
}
