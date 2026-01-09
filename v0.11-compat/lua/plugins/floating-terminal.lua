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
		{
			"<C-g>",
			function()
				local Terminal = require("toggleterm.terminal").Terminal
				local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
				lazygit:toggle()
			end,
			desc = "Toggle LazyGit",
		},
	},
	opts = {
		direction = "float",
		float_opts = {
			border = "double",
			title_pos = "center",
		},
	},
}
