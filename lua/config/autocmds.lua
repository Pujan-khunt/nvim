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

-- auto-run lint on save
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.go",
	callback = function()
		-- run all go formatters, including golangci-lint
		require("conform").format({
			bufnr = 0,
			formatters = { "gofumpt", "goimports", "golangci_lint" },
			async = true,
		})
	end,
})

-- Format on save using conform.nvim
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		-- require("conform").format({ bufnr = args.buf })
		vim.lsp.buf.format({
			bufnr = args.buf,
			async = true,
			formatting_options = {
				tabSize = 4,
				insertSpaces = false,
				trimTrailingWhitespace = true,
				insertFinalNewline = true,
				trimFinalNewlines = true,
			},
		})
	end,
})
