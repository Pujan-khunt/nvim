return {
	-- install without yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_auto_open = 1
			vim.g.mkdp_browser = "firefox"
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	},
}
