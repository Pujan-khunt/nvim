--- @module "lazy"
--- @type LazySpec
return {
	"NickvanDyke/opencode.nvim",
	dependencies = {
		{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
	},
	init = function()
		---@type opencode.Opts
		vim.g.opencode_opts = {
			provider = {
				enabled = "tmux",
			},
		}
		vim.o.autoread = true
	end,
	keys = {
		{
			"<leader>oa",
			function()
				require("opencode").ask("@this: ", { submit = true })
			end,
			mode = { "n", "x" },
			desc = "Ask opencode",
		},
		{
			"<leader>os",
			function()
				require("opencode").select()
			end,
			mode = { "n", "x" },
			desc = "Select opencode action",
		},
		{
			"<leader>ot",
			function()
				require("opencode").toggle()
			end,
			mode = { "n", "t" },
			desc = "Toggle opencode",
		},
		{
			"<C-]>",
			function()
				require("opencode").command("session.half.page.up")
			end,
			mode = { "n", "t" },
			desc = "Scroll up in the session window",
		},
		{
			"<C-[>",
			function()
				require("opencode").command("session.half.page.down")
			end,
			mode = { "n", "t" },
			desc = "Scroll down in the session window",
		},
	},
}
