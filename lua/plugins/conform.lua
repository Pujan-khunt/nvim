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
			formatters = {
				golangci_lint = {
					command = "golangci-lint",
					args = { "run", "--out-format", "json", "--path-prefix", vim.fn.getcwd() },
					stdin = false, -- golangci-lint reads files directly
					cwd = require("conform.util").root_file({ "go.mod", ".git" }),
					require_cwd = true,
					condition = function()
						return vim.fn.filereadable("go.mod") == 1
					end,
				},
			},
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
