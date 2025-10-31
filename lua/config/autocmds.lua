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

-- Prevent overflow when diffing files using DiffView
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "gitcommit", "gitrebase" },
	callback = function()
		vim.opt_local.wrap = true
	end,
})

-- Comment settings for JavaScript/TypeScript (no plugins)
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascriptreact", "typescriptreact" },
	callback = function()
		vim.bo.commentstring = "{/* %s */}"
	end,
})
