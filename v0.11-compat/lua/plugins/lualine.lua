--- @module "lazy"
--- @type LazySpec
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "kanagawa",
			globalstatus = true,
			component_separators = { left = "│", right = "│" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				{ "filename", path = 1 }, -- path = 1 shows the relative path
			},
			lualine_x = {
				function()
					local conform = require("conform")
					local status, formatters = pcall(conform.list_formatters_to_run, 0)
					if not status then
						return ""
					end

					local fmt_names = {}
					for _, formatter in ipairs(formatters) do
						table.insert(fmt_names, formatter.name)
					end

					if #fmt_names > 0 then
						return "󰷈 " .. table.concat(fmt_names, ", ")
					end
					return ""
				end,
				"encoding",
				{
					"filetype",
					icon_only = true,
					separator = "",
					padding = { left = 1, right = 0 },
				},
				{
					function()
						-- Fetch LSP clients attached to the current buffer
						local clients = vim.lsp.get_clients({ bufnr = 0 })
						if next(clients) == nil then
							return "No LSP"
						end

						-- Add all in a table
						local client_names = {}
						for _, client in ipairs(clients) do
							table.insert(client_names, client.name)
						end

						return table.concat(client_names, ", ")
					end,
					padding = { left = 1, right = 1 },
				},
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}
