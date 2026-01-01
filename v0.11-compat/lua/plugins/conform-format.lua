--- @module "lazy"
--- @type LazySpec
return {
	"stevearc/conform.nvim",

	--- @module "conform"
	--- @type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
		},
		--- @type conform.FormatOpts
		format_after_save = {
			async = true,
			lsp_format = "fallback",
			stop_after_first = true,
		},
	},
}
