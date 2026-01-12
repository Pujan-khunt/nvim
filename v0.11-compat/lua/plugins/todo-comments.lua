--- @module "lazy"
--- @type LazySpec
return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufEnter" },
	opts = {
		keywords = {
			QUESTION = {
				icon = "", -- Icon to show
				color = "warning", -- Color group (info, warning, error, hint, test)
				alt = { "QUES", "faq" }, -- Alternate aliases for the same tag
			},
			-- You can also override defaults here if you want:
			-- TODO = { icon = " ", color = "info" },
		},
		highlight = {
			before = "", -- "fg" or "bg" or empty
			keyword = "wide_fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty.
			after = "fg", -- "fg" or "bg" or empty
		},
	},
	keys = {
		-- Optional: Keymaps to search specifically for your questions/todos
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next Todo Comment",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Previous Todo Comment",
		},
		{
			"<leader>st",
			"<cmd>TodoTelescope<cr>",
			desc = "Search Todos (and Questions)",
		},
	},
}
