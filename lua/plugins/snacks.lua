return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		lazygit = {
			win = {
				style = {
					border = "rounded",
				},
			},
			theme = {
				-- Make the selected line background more prominent
				selectedLineBgColor = { bg = "IncSearch" },
				-- Make inactive borders less distracting
				inactiveBorderColor = { fg = "Comment" },
				-- Make active borders a different color
				activeBorderColor = { fg = "String", bold = true },
			},
		},
	},
}
