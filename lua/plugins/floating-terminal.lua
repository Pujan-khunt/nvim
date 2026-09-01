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
	--- @module "toggleterm"
	--- @type ToggleTermConfig
	---@diagnostic disable-next-line: missing-fields
	opts = {
		direction = "float",
		autochdir = true,
		winbar = {
			enabled = true,
		},
		float_opts = {
			title_pos = "center",
		},
	},
}
