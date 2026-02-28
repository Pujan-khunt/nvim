--- @module "lazy"
--- @type LazySpec
return {
	"tpope/vim-fugitive",
	keys = {
		{
			"<leader>g",
			"<cmd>Git<CR>",
			mode = { "n", "v" },
			desc = "Open Vim Fugitive",
		},
	},
}
