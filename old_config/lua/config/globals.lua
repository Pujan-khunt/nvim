return function(_, bufnr)
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
	end

	map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Go to Definition")
	map("n", "gr", "<cmd>Telescope lsp_references<CR>", "References")
	map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Implementations")
	map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
	map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
	map("n", "K", vim.lsp.buf.hover, "Hover Doc")
end
