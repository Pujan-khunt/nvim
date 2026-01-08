--- @module "lazy"
--- @type LazySpec
return {
	"akinsho/toggleterm.nvim",
	keys = {
		{
			"<C-\\>",
			"<cmd>ToggleTerm<CR>",
			mode = { "n", "t" },
			desc = "Toggle floating terminal",
		},
	},
	opts = {},
}
