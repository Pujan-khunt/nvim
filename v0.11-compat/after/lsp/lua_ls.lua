return {
	settings = {
		Lua = {
			hint = {
				enable = true,
			},
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				-- make the server aware of Neovim runtime files
				library = {},
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
}
