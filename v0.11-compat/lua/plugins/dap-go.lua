return {
	"leoluz/nvim-dap-go",
	ft = "go",
	dependencies = { "mfussenegger/nvim-dap" },
	config = function()
		require("dap-go").setup()

		-- Go-specific testing keymaps
		local map = vim.keymap.set

		map("n", "<leader>dgt", function()
			require("dap-go").debug_test()
		end, { desc = "Go: Debug Test" })
		map("n", "<leader>dgl", function()
			require("dap-go").debug_last_test()
		end, { desc = "Go: Debug Last Test" })
	end,
}
