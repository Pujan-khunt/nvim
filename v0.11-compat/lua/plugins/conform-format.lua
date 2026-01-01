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
		format_after_save = function(bufnr)
			--- @type conform.FormatOpts
			local formatOptions = {
				async = true,
				lsp_format = "fallback",
				stop_after_first = true,
			}

			local conform = require("conform")
			local formatters = conform.list_formatters_to_run(bufnr)

			-- Collect the names of all formatters
			local fmt_names = {}
			for _, fmt in ipairs(formatters) do
				table.insert(fmt_names, fmt.name)
			end

			if #fmt_names > 0 then
				local msg = "Formatting with: " .. table.concat(fmt_names, ", ")
				vim.notify(msg, vim.log.levels.INFO, { timeout = 3000, title = "Conform" })
			end

			return formatOptions
		end,
	},
}
