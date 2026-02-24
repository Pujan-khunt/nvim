vim.diagnostic.config({
	virtual_text = true,
	-- virtual_lines = true,
	update_in_insert = false,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘", -- or 
			[vim.diagnostic.severity.WARN] = "▲", -- or 
			[vim.diagnostic.severity.HINT] = "⚑", -- or 
			[vim.diagnostic.severity.INFO] = "»", -- or 
		},
	},
})

vim.lsp.enable({ "lua_ls", "jdtls" })
