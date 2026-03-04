-- nvim/lua/plugins/dap.lua
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio", -- dependency for nvim-dap-ui
		{
			"jay-babu/mason-nvim-dap.nvim",
			opts = {
				ensure_installed = {
					"delve", -- Go debugger
					"go-debug-adapter", -- Go debug adapter
					"javadbg", -- Java debug adapter
					"javatest", -- Java test adapter
				},
			},
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Highlight colors and signs
		vim.api.nvim_set_hl(0, "DapBreakpoint", { link = "DiagnosticError" })
		vim.api.nvim_set_hl(0, "DapStopped", { link = "String" })
		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "◆", texthl = "DapBreakpoint", linehl = "", numhl = "" }
		)
		vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "CursorLine", numhl = "" })

		dapui.setup()

		-- Automatically toggle the UI
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

		-- Global debug keymaps
		local map = vim.keymap.set
		map("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		map("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
		map("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
		map("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
		map("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		map("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Conditional Breakpoint" })
	end,
}
