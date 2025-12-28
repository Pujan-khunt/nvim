return {
	"stevearc/conform.nvim",
	opts = {},
	event = { "BufWritePre" },
	config = function()
		local local_opts = {
			log_level = vim.log.levels.ERROR,
			formatters_by_ft = {
				svelte = { "prettier" },
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "biome" },
				typescriptreact = { "biome" },
				json = { "biome" },
				jsonc = { "biome" },
				java = { "google-java-format" },
				go = { "gofumpt" },
				sql = { "sleek" },
				["_"] = { "trim_whitespace" },
			},

			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		}
		require("conform").setup(local_opts)
	end,
}
