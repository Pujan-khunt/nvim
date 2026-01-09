--- @module "lazy"
--- @type LazySpec
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	--- @module "lualine"
	opts = {
		globalstatus = true,
		sections = {
			lualine_x = { "lsp_status" },
			lualine_y = {
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
			},
			lualine_z = { "progress" },
		},
		tabline = {
			lualine_x = { "b:toggle_number" },
			lualine_y = { "filename" },
			lualine_z = { "filesize" },
		},
	},
}
