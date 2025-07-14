return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"saghen/blink.cmp",
		event = { "InsertEnter" },
		dependencies = {
			{ "L3MON4D3/LuaSnip", version = "v2.*" },
		},
		version = "1.*",
		---@module "blink.cmp"
		---@diagnostic disable-next-line: undefined-doc-name
		---@type blink.cmp.Config
		opts = {
			snippets = {
				preset = "luasnip",
			},
			keymap = {
				preset = "default",
				-- If completion window is not open then open it with the first entry preselected,
				-- else select the corresponding entry
				["<C-j>"] = { "show", "select_next", "fallback" },
				["<C-k>"] = { "show", "select_prev", "fallback" },
				-- Navigate Back and Forth for Snippets
				["<C-h>"] = { "snippet_backward", "fallback" },
				-- <C-l> is used to accept a entry in completion window when there is no snippet forwarding
				["<C-l>"] = { "snippet_forward", "select_and_accept", "fallback" },
				["<C-Space>"] = { "cancel", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "normal",
			},
			signature = { enabled = true },
			completion = {
				keyword = { range = "full" },
				ghost_text = { enabled = false },
				trigger = {
					show_in_snippet = false,
					show_on_backspace = true,
					-- (To view the documentation for the keyword)
					show_on_keyword = true,
					-- Automatically open completion window when a specific character like "."
					-- is used. (To view properties and functions for a keyword. Ex. vim.api.|   <-- here as soon as I type the "." the window should appear)
					show_on_trigger_character = true,
					show_on_blocked_trigger_characters = { " ", "\n", "\t" },
					--
					show_on_insert_on_trigger_character = true,
				},
				accept = {
					dot_repeat = true,
					auto_brackets = {
						enabled = true,
						default_brackets = { "(", ")" },
						kind_resolution = {
							enabled = true,
							blocked_filetypes = { "typescriptreact", "javascriptreact", "vue" },
						},
						semantic_token_resolution = {
							enabled = true,
							blocked_filetypes = { "java" },
							-- How long to wait for semantic tokens to return before assuming no brackets should be added
							timeout_ms = 400,
						},
					},
				},
				menu = {
					enabled = true,
					border = "single",
				},
				documentation = {
					auto_show = true,
					window = {
						border = "rounded",
					},
				},
			},
			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
