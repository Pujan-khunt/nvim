--- @module "lazy"
--- @type LazySpec
return {
	"stevearc/oil.nvim",

	--- @module "oil"
	--- @type oil.SetupOpts
	opts = {
		skip_confirm_for_simple_edits = true,
		delete_to_trash = true,
		watch_for_changes = true,
		keymaps = {
			["l"] = { "actions.select", mode = "n" },
			["h"] = { "actions.parent", mode = "n" },
			["<C-v>"] = { "actions.select", opts = { vertical = true } },
			["<C-h>"] = { "actions.select", opts = { horizontal = true } },
		},
	},
}
