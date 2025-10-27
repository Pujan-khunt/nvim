-- Highlight Yanked Text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Highlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			hlgroup = "Visual",
			timeout = 300,
		})
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "gitcommit", "gitrebase" },
	callback = function()
		vim.opt_local.wrap = true
	end,
})
