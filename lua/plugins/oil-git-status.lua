return {
	"benomahony/oil-git.nvim",
	dependencies = { "stevearc/oil.nvim" },
	opts = {
		highlights = {
			OilGitAdded = { fg = "#98c379" }, -- Muted green for additions
			OilGitModified = { fg = "#e5c07b" }, -- Golden yellow matching your screenshot
			OilGitRenamed = { fg = "#c678dd" }, -- Soft purple
			OilGitDeleted = { fg = "#e06c75" }, -- Muted red
			OilGitCopied = { fg = "#c678dd" }, -- Soft purple
			OilGitConflict = { fg = "#d19a66" }, -- Orange for conflicts
			OilGitUntracked = { fg = "#61afef" }, -- Soft blue
			OilGitIgnored = { fg = "#5c6370" }, -- Dimmed grey for ignored files
		},
	},
}
