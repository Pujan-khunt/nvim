--- @module "lazy"
--- @type LazySpec
return {
	-- 1. The Debugger Interface (nvim-dap)
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui", -- Nice UI for the debugger
			"nvim-neotest/nvim-nio", -- Required by dap-ui
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
			-- dap.listeners.before.event_terminated.dapui_config = function()
			-- 	dapui.close()
			-- end
			-- dap.listeners.before.event_exited.dapui_config = function()
			-- 	dapui.close()
			-- end
		end,
	},

	-- 2. The Java Adapter (nvim-jdtls)
	{
		"mfussenegger/nvim-jdtls",
		ft = "java", -- Only load on java files
		config = function()
			local home = os.getenv("HOME")
			local jdtls = require("jdtls")
			local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
			local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

			local debug_adapter_jar = vim.fn.glob(
				home
					.. "/Downloads/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
			)
			if debug_adapter_jar == "" then
				vim.notify(
					"❌ Debug adapter JAR not found. Check your ~/Downloads/java-debug path.",
					vim.log.levels.ERROR
				)
			end

			-- Only 'bundles' are needed for debugging
			local bundles = { debug_adapter_jar }

			local jdtls_path = home .. "/Downloads/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository"
			local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

			-- Determine OS config (linux/mac/windows)
			local system = vim.uv.os_uname().sysname
			local config_dir = system == "Darwin" and "config_mac"
				or (system == "Linux" and "config_linux" or "config_win")

			-- -----------------------------------------------------------------------
			-- 3. THE CONFIGURATION
			-- -----------------------------------------------------------------------
			local config = {
				cmd = {
					"java",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dosgi.checkConfiguration=true",
					"-Dosgi.sharedConfiguration.area=" .. jdtls_path .. "/" .. config_dir,
					"-Dosgi.sharedConfiguration.area.readOnly=true",
					"-Dosgi.configuration.cascaded=true",
					"-noverify",
					"-Xms1G",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-jar",
					launcher_jar,
					"-data",
					workspace_dir,
				},
				root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

				-- This is where we plug in the debugger
				init_options = {
					bundles = bundles,
				},

				on_attach = function(_, bufnr)
					-- Activate the debugger
					jdtls.setup_dap({ hotcodereplace = "auto" })
					require("jdtls.dap").setup_dap_main_class_configs()

					-- Keymappings for debugging
					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
					end

					map("n", "<leader>db", require("dap").toggle_breakpoint, "Debug: Toggle Breakpoint")
					map("n", "<leader>ds", require("dap").continue, "Debug: Start/Continue")
					map("n", "<leader>dc", require("dapui").close, "Close Debug UI")
					map("n", "<C-]>", require("dap").step_over, "Debug: Step Over")
					map("n", "<C-[>", require("dap").step_into, "Debug: Step Into")
				end,
			}

			-- Start the server
			jdtls.start_or_attach(config)
		end,
	},
}
