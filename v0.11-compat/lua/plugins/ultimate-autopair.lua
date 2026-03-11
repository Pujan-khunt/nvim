--- @module "lazy"
--- @type LazySpec
return {
	"altermo/ultimate-autopair.nvim",
	event = { "InsertEnter", "CmdlineEnter" },
	branch = "v0.6",
	opts = {
		fastwarp = {
			map = "<C-l>",
			rmap = "<C-h>",
			cmap = "<C-l>",
			rcmap = "<C-h>",
		},
	},
}
