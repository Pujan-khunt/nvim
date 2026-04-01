local util = require("lspconfig.util")

--- @type vim.lsp.Config
return {
	root_markers = { ".venv", "requirements.txt" },
	on_init = function(client)
		-- Dynamically find the .venv and tell PyLSP to use it
		local path = client.workspace_folders[1].name
		local venv_path = path .. "/.venv"

		if vim.fn.isdirectory(venv_path) == 1 then
			client.config.settings.pylsp.plugins.jedi.environment = venv_path
			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
		return true
	end,
	settings = {
		pylsp = {
			plugins = {
				jedi = {
					environment = nil, -- Populated dynamically above
				},
				-- Explicitly enable hover and signature help
				jedi_hover = { enabled = true },
				jedi_signature_help = { enabled = true },
			},
		},
	},
}
