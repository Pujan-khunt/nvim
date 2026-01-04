--- @module "lazy"
--- @type LazySpec
return {
	"altermo/ultimate-autopair.nvim",
	event = { "InsertEnter", "CmdlineEnter" },
	branch = "v0.6",
	opts = {
		space2 = { enable = true },
		fastwarp = { enable = true, multi = true },
		extensions = {
			suround = { p = 20 },
		},
	},
}
