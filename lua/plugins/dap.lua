return {
	--
	-- 1. Core DAP Plugin
	--
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- 2. DAP UI
			-- This provides the nice UI for scopes, breakpoints, etc.
			"rcarriga/nvim-dap-ui",

			-- 3. (FIX) nvim-dap-ui's dependency
			-- This is what your error message was asking for.
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			--
			-- MANUALLY CONFIGURE THE DELVE ADAPTER
			--
			-- This tells nvim-dap *how* to launch the delve adapter
			-- that mason.nvim installed.
			dap.adapters.delve = {
				type = "server",
				port = "${port}",
				executable = {
					-- This command finds the 'delve' binary installed by Mason
					command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
					args = { "dap", "-l", "127.0.0.1:${port}" },
				},
			}

			--
			-- MANUALLY DEFINE GO CONFIGURATIONS
			--
			-- This is the step that fixes your "no configuration" error.
			-- It tells nvim-dap what to *do* when you want to debug a Go file.
			dap.configurations.go = {
				{
					type = "delve",
					name = "Launch file", -- The name you'll see in the menu
					request = "launch",
					program = "${file}", -- Debug the current file
				},
				{
					type = "delve",
					name = "Launch test", -- Debug the test function under your cursor
					request = "launch",
					mode = "test",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Launch test (package)", -- Debug all tests in the current file's package
					request = "launch",
					mode = "test",
					program = "${fileDirname}",
				},
			}

			--
			-- DAP UI SETUP
			--
			dapui.setup({
				layouts = {
					{
						elements = { "scopes", "breakpoints", "stacks", "watches" },
						size = 60,
						position = "left",
					},
					{
						elements = { "repl", "console" },
						size = 20,
						position = "bottom",
					},
				},
				floating = {
					max_height = 0.9,
					max_width = 0.9,
				},
			})

			--
			-- SIGNS & KEYMAPS
			--
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "ErrorMsg", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiffAdd", linehl = "", numhl = "" })

			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ebug: Toggle [B]reakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[D]ebug: [C]ontinue" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "[D]ebug: [N]ext (Step Over)" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "[D]ebug: Step [I]nto" })
			vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "[D]ebug: Step [O]ut" })
			vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "[D]ebug: [T]erminate" })
			vim.keymap.set("n", "<leader>dr", dap.run_last, { desc = "[D]ebug: [R]un Last" })
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "[D]ebug: Toggle [U]I" })

			-- Auto-toggle UI on session start/stop
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
