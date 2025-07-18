return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = function()
		local bf = require("bufferline")

		return {
			highlights = {
				buffer_selected = { bold = true },
				diagnostic_selected = { bold = true },
				info_selected = { bold = true },
				info_diagnostic_selected = { bold = true },
				warning_selected = { bold = true },
				warning_diagnostic_selected = { bold = true },
				error_selected = { bold = true },
				error_diagnostic_selected = { bold = true },
			},
			options = {
				style_preset = bf.style_preset.minimal,
				themable = true,
				diagnostics = "nvim_lsp",
				separator_style = "slope",
			},
		}
	end,
}
