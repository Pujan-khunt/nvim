--- @module "lazy"
--- @type LazySpec
return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope", -- Lazy load based on this command.
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>fd",
			function()
				require("telescope.builtin").find_files({
					cwd = vim.fn.getcwd(),
					hidden = true,
					follow = true, -- Follow symlinks to edit the original file.
				})
			end,
			desc = "Find files in current working directory",
		},
		{
			"<leader>lg",
			function()
				require("telescope.builtin").live_grep({ cwd = vim.fn.getcwd() })
			end,
			desc = "Live grep in current working directory",
		},
		{
			"<leader>fr",
			function()
				require("telescope.builtin").resume()
			end,
			desc = "Resume last opened picker",
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags({ lang = "en" })
			end,
			desc = "Help tags picker",
		},
		{
			"<leader>fs",
			function()
				require("telescope.builtin").search_history()
			end,
			desc = "Telescope history picker",
		},
		{
			"<leader>nh",
			function()
				require("telescope").load_extension("notify")
				require("telescope").extensions.notify.notify()
			end,
		},
	},
	opts = {
		defaults = {
			dynamic_preview_title = true,

			-- Classic.
			results_title = "You can't spell advertisements without semen between the tits",

			-- Ignore .env files to risk exposing secrets
			-- Ignore node_modules and .git for obvious reasons
			file_ignore_patterns = { "%.env", "^node_modules/", "^.git" },
			mappings = {
				-- See telescope.actions for more
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
					["<C-v>"] = "file_vsplit",
					["<C-h>"] = "file_split",
					["<C-l>"] = "select_default",
					["<C-;>"] = "close",
				},
			},
		},
	},
}
