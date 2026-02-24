--- @module "lazy"
--- @type LazySpec
return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope", -- Lazy load based on this command.
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
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
				local theme = require("telescope.themes").get_dropdown({ cwd = vim.fn.getcwd() })
				require("telescope.builtin").live_grep(theme)
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
	},
	opts = {
		defaults = {
			dynamic_preview_title = true,

			-- Classic.
			results_title = "You can't spell advertisements without semen between the tits",

			-- Ignore .env files to risk exposing secrets
			-- Ignore node_modules, .git and .class for obvious reasons
			file_ignore_patterns = { "%.env", "^node_modules/", "^.git", "%.class" },
			mappings = {
				-- See telescope.actions for more
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
					["<C-v>"] = "file_vsplit",
					["<C-h>"] = "file_split",
					["<C-l>"] = "select_default",
					["<C-o>"] = "close",
				},
			},
		},
	},
}
