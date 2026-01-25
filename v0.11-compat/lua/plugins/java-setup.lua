--- @module "lazy"
--- @type LazySpec
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio", -- dap-ui dependency
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()

			-- Open the debugger UI automatically when you start debugging
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
	},
}
