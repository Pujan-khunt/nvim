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

-- Format on save using conform.nvim
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- Detect "i3config" filetypes
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*/i3/**/*.conf",
	callback = function()
		vim.bo.filetype = "i3config"
	end,
})
