--- @module "lazy"
--- @type LazySpec
return {
	"saghen/blink.cmp",

	-- https://github.com/rafamadriz/friendly-snippets
	dependencies = { "rafamadriz/friendly-snippets" },

	build = "cargo +nightly build --release",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = {
			preset = "none",
			-- Navigation in completion window
			["<C-j>"] = { "show", "select_next", "fallback" },
			["<C-k>"] = { "show", "select_prev", "fallback" },

			-- Accept currently selected entry from completion window
			-- Snippet navigation
			["<C-l>"] = { "select_and_accept", "snippet_forward", "fallback" },
			["<C-h>"] = { "snippet_backward", "fallback" },

			["<C-p>"] = { "show_signature", "hide_signature", "fallback" },

			-- Documentation navigation
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
		},

		appearance = {
			nerd_font_variant = "normal",
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			accept = { auto_brackets = { enabled = true } },
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
			list = { selection = { preselect = true, auto_insert = false } },
			-- menu = { auto_show },
			ghost_text = { enabled = true, show_with_selection = true },
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			per_filetype = {
				lua = { inherit_defaults = true, "lazydev" },
			},
			default = function()
				local success, node = pcall(vim.treesitter.get_node)

				if success and node then
					if
						vim.tbl_contains({ "comment", "comment_content", "line_comment", "block_comment" }, node:type())
					then
						return { "buffer" }
					end
				end

				return { "lazydev", "lsp", "path", "snippets", "buffer" }
			end,
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
				snippets = {
					name = "Snippets",
					module = "blink.cmp.sources.snippets",
					transform_items = function(_, items)
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local line = vim.api.nvim_get_current_line()
						local cursor_before_line = line:sub(1, col)
						-- Match the word characters before the cursor (e.g., "sysout")
						local keyword = cursor_before_line:match("[%w_\\-]+$")

						if keyword then
							for _, item in ipairs(items) do
								-- Apply the range to replace the typed keyword with the snippet body
								item.textEdit = {
									newText = item.insertText or item.label,
									range = {
										start = { line = vim.fn.line(".") - 1, character = col - #keyword },
										["end"] = { line = vim.fn.line(".") - 1, character = col },
									},
								}
							end
						end
						return items
					end,
				},
			},
		},

		signature = { enabled = true, window = { show_documentation = false } },
		-- signature = { enabled = true },

		fuzzy = { implementation = "rust" },
	},
	opts_extend = { "sources.default" },
}
