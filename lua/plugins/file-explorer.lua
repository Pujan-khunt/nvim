return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	dependencies = {
		{ "echasnovski/mini.icons", opts = {} },
	},
	lazy = false,
	opts = {
		default_file_explorer = true, -- Hijack Netrw
		columns = {
			"icon",
		},
		delete_to_trash = true,
		prompt_save_on_select_new_entry = true,
		watch_for_changes = true, -- Watches for filesystem changes and updates
		use_default_keymaps = false,
		keymaps = {
			["l"] = { "actions.select", mode = "n" }, -- Enter the node
			["h"] = { "actions.parent", mode = "n" }, -- Go one directory up
			["<C-h>"] = {}, -- Disable the normal functioning of <C-h>. <C-h> is used for transitioning to the left window in neovim.
			["<C-l>"] = {},
			["g."] = { "actions.toggle_hidden", mode = "n" },
			["<C-M-m>"] = "actions.preview",
		},
		view_options = {
			show_hidden = true,
		},
	},
}
