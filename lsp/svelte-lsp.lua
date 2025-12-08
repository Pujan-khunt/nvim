local blink = require("blink.cmp")
local on_attach = require("config.globals")

-- REPLACE THIS with the absolute path to your downloaded language-server directory
-- Example: "/home/username/downloads/language-server"
local svelte_ls_path = "/home/pujan/Downloads/language-tools-svelte-language-server-0.17.21/packages/language-server"

return {
	on_attach = on_attach,
	-- Updated command to use the local binary
	cmd = {
		"node",
		svelte_ls_path .. "/bin/server.js",
		"--stdio",
	},
	filetypes = { "svelte" },
	root_markers = { "svelte.config.ts", "svelte.config.js", "package.json", ".git", "tsconfig.json", "jsconfig.json" },
	settings = {
		svelte = {
			plugin = {
				svelte = {
					format = { enable = true },
					hover = { enable = true },
					compilerWarnings = { enable = true },
				},
				css = {
					enable = true,
					hover = { enable = true },
					completions = { enable = true },
				},
				html = {
					enable = true,
					hover = { enable = true },
					completions = { enable = true },
				},
				typescript = {
					enable = true,
					diagnostics = { enable = true },
					hover = { enable = true },
					completions = { enable = true },
				},
			},
		},
	},
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink.get_lsp_capabilities()
	),
}
