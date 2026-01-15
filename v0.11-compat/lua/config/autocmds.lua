local function augroup(name)
	return vim.api.nvim_create_augroup("augroup_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
	group = augroup("auto_refresh_codelens"),
	pattern = "*",
	callback = function()
		-- Only refresh if the client supports it
		local client = vim.lsp.get_clients({ bufnr = 0 })[1]
		if client and client:supports_method("textDocument/codeLens") then
			vim.lsp.codelens.refresh({ bufnr = 0 })
		end
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup("lsp_keybinds"),
	callback = function(args)
		local bufnr = args.buf
		local builtin = require("telescope.builtin")

		local function map(mode, keybind, command, description)
			vim.keymap.set(mode, keybind, command, { desc = description, buffer = bufnr })
		end

		map("n", "gd", vim.lsp.buf.definition, "LSP: Go to Definition")
		map("n", "gD", vim.lsp.buf.declaration, "LSP: Go to Declaration")
		map("n", "gi", vim.lsp.buf.implementation, "LSP: Go to Implementation")
		map("n", "go", vim.lsp.buf.type_definition, "LSP: Go to Type Definition")
		map("n", "gr", builtin.lsp_references, "LSP: Go to References")
		map("n", "K", vim.lsp.buf.hover, "LSP: Hover Documentation")
		map("i", "<C-u>", vim.lsp.buf.signature_help, "LSP: Signature Help")
		map("n", "M", vim.lsp.buf.signature_help, "LSP: Signature Help")
		map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")

		-- Keybind to toggle them
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		map("n", "<leader>th", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
		end, "LSP: Toggle Inlay Hints")

		-- Already created defaults
		-- map("n", "[d", vim.diagnostic.goto_prev, "Diagnostic: Go to previous")
		-- map("n", "]d", vim.diagnostic.goto_next, "Diagnostic: Go to next")
		map("n", "<leader>of", vim.diagnostic.open_float, "Diagnostic: Show line diagnostics")
		map("n", "<leader>ol", vim.diagnostic.setloclist, "Diagnostic: Open location list")
	end,
})
