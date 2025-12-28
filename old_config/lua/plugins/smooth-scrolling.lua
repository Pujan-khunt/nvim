return {
	"karb94/neoscroll.nvim",
	opts = {},
	config = function()
		vim.keymap.set("n", "<C-k>", function()
			require("neoscroll").scroll(-30, { move_cursor = true, duration = 300 })
		end, { desc = "Smooth Scroll 30 Lines Above", noremap = true })

		vim.keymap.set("n", "<C-j>", function()
			require("neoscroll").scroll(30, { move_cursor = true, duration = 300 })
		end, { desc = "Smooth Scroll 30 Lines Below", noremap = true })
	end,
}
