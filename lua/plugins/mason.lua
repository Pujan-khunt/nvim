return {
	{
		"mason-org/mason.nvim",
		lazy = false, -- Load immediately to ensure PATH is set
		cmd = "Mason",
		keys = { { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
			-- NOTE: Names should match package names in "Mason" not the binary names.
			ensure_installed = {
				-- LSP servers (matching your vim.lsp.enable() config)
				"lua-language-server", -- Lua LSP
				-- "jdtls", -- Java LSP
				"typescript-language-server", -- JavaScript/TypeScript LSP

				-- Formatters/Linters
				"biome", -- JS/TS
				"stylua", -- Lua
				"google-java-format", -- Java

				-- Golang
				"gofumpt",
				"goimports",
				"golangci-lint",
				"gopls",

				"clangd",
				"gh-actions-language-server",
				"jtdls",
			},
		},
		config = function(_, opts)
			-- PATH is handled by core.mason-path for consistency
			require("mason").setup(opts)

			-- Auto-install ensure_installed tools with better error handling
			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					if mr.has_package(tool) then
						local p = mr.get_package(tool)
						if not p:is_installed() then
							vim.notify("Mason: Installing " .. tool .. "...", vim.log.levels.INFO)
							p:install():once("closed", function()
								if p:is_installed() then
									vim.notify("Mason: Successfully installed " .. tool, vim.log.levels.INFO)
								else
									vim.notify("Mason: Failed to install " .. tool, vim.log.levels.ERROR)
								end
							end)
						end
					else
						vim.notify("Mason: Package '" .. tool .. "' not found", vim.log.levels.WARN)
					end
				end
			end

			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
}
