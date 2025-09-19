return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },
	-- telescope-ui-select extension requires a global variable to set before the plugin is loaded.
	-- init() runs before the plugin is loaded.
	init = function()
		vim.g.telescope_ui_select_replace = true
	end,
	opts = {
		defaults = {
			scroll_strategy = "limit", -- Limit if tried to scroll past the start or end of the list
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			prompt_prefix = "Files > ",
			selection_caret = "→ ",
			initial_mode = "insert",
			hidden = true,
			file_ignore_patterns = {
				"^%.git",
				"^node_modules/%",
			},
			mappings = {
				i = {
					["<c-k>"] = "move_selection_previous",
					["<c-j>"] = "move_selection_next",
					["<c-l>"] = "select_default",
				},
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
			["ui-select"] = {
				require("telescope.themes").get_dropdown({
					previewer = false,
				}),
			},
		},
		pickers = {},
	},
	-- Setting Telescope Specific Keymaps
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")

		local builtin = require("telescope.builtin")
		local config_dir = "$HOME/.config/nvim/"
		local cwd = vim.fn.getcwd()

		-- Find files using grep in the cwd.
		vim.keymap.set("n", "<leader>fg", function()
			builtin.live_grep({ cwd = cwd })
		end, { desc = "Live Grep - CWD" })

		-- Find files in the cwd.
		vim.keymap.set("n", "<leader>fd", function()
			builtin.find_files({ cwd = cwd, hidden = true })
		end, { desc = "Find Files - CWD" })

		-- Find files in the neovim config dir.
		vim.keymap.set("n", "<leader>fcd", function()
			builtin.find_files({ cwd = config_dir, hidden = true, no_ignore = false })
		end, { desc = "Find Files - Config" })

		-- Find files using grep in neovim config dir.
		vim.keymap.set("n", "<leader>fcg", function()
			builtin.live_grep({ cwd = config_dir })
		end, { desc = "Live Grep - Config" })

		-- Fuzzy search highlights
		vim.keymap.set("n", "<leader>fl", builtin.highlights, { desc = "Fuzzy Search Highlights" })

		-- Fuzzy search help tags like telescope.builtins etc.
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search Help Pages" })

		-- Resume to the previously opened telescope window with the same state(prompt)
		vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume Previous State" })
	end,
}
