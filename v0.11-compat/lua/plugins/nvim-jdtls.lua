--- @module "lazy"
--- @type LazySpec
return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio", -- Required dependency for dap-ui
			{
				"jay-babu/mason-nvim-dap.nvim",
				opts = {
					-- Available DAP Adapters (https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua)
					ensure_installed = {
						"javadbg", -- Java Debug Adapter
						"javatest", -- Java Test (For debugging with JUnit)
					},
				},
			},
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			-- Set up the highlight colors for the debug signs
			vim.api.nvim_set_hl(0, "DapBreakpoint", { link = "DiagnosticError" })
			vim.api.nvim_set_hl(0, "DapStopped", { link = "String" })

			-- Define the VS Code style icons
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "◆", texthl = "DapBreakpoint", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "CursorLine", numhl = "" })

			-- Setup the UI with default settings
			dapui.setup()

			-- Automatically open the UI when a debug session starts, and close it when it ends
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
}
