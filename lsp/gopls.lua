-- File: nvim/lsp/gopls.lua

local on_attach = require("config.globals")
local blink = require("blink.cmp")

return {
	on_attach = on_attach,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod", ".git" },
	settings = {
		gopls = {
			-- Use gofumpt for formatting, which is handled by conform.nvim
			gofumpt = true,

			-- Enable staticcheck for advanced static analysis.
			staticcheck = true,

			codelenses = {
				generate = true,
				gc_details = true,
				test = true,
				tidy = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			analyses = {
				unusedwrite = true,
				shadow = true,
			},
			buildFlags = { "-tags=integration" },
			experimentalPostfixCompletions = true,
		},
	},
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink.get_lsp_capabilities()
	),
}
