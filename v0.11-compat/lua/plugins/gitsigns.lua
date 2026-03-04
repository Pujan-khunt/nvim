--- @module "lazy"
--- @type LazySpec
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<leader>hg",
			"<cmd>Gitsigns<CR>",
			mode = { "n", "v" },
			desc = "Select Gitsigns Action",
		},
		{
			"<leader>ph",
			function()
				require("gitsigns").preview_hunk_inline()
			end,
			mode = { "n" },
		},
		{
			"]h",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					require("gitsigns").nav_hunk("next")
				end
			end,
			mode = { "n" },
		},
		{
			"[h",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					require("gitsigns").nav_hunk("prev")
				end
			end,
			mode = { "n" },
		},
	},
	opts = {},
}
