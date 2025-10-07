return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		local local_opts = {
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			log_level = vim.log.levels.ERROR,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "biome" },
				typescript = { "biome" },
				javascriptreact = { "biome" },
				typescriptreact = { "biome" },
				json = { "biome" },
				jsonc = { "biome" },
				java = { "google-java-format" },
				go = { "gofumpt", "goimports" },
				sql = { "sleek" },
				["_"] = { "trim_whitespace" },
			},
		}
		require("conform").setup(local_opts)
	end,
}
