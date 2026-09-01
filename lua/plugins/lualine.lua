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
				"filetype",
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}
