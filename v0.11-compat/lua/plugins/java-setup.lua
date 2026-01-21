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
			local config_dir = "config_linux"

			local config = {
				settings = {
					java = {
						configuration = {
							runtimes = {
								{
									name = "JavaSE-21",
									path = "/usr/lib/jvm/java-21-openjdk",
									default = true,
								},
								{
									name = "JavaSE-17",
									path = "/usr/lib/jvm/java-17-openjdk",
								},
							},
						},
						-- Tell JDTLS to load sources.
						-- This works for both dependencies and the JDK standard library.
						eclipse = {
							downloadSources = true,
						},
						maven = {
							downloadSources = true,
						},
						references = {
							includeDecompiledSources = true,
						},
						signatureHelp = { enabled = true },
						contentProvider = { preferred = "fernflower" }, -- Fallback to decompiler if source not found
						format = {
							comments = { enabled = false },
							enabled = true,
							insertSpaces = true,
							onType = { enabled = false },
							tabSize = 4,
							settings = {
								url = vim.fn.stdpath("config") .. "/lua/config/google-formatter.xml",
								profile = "GoogleStyle",
							},
						},
					},
				},
				cmd = {
					"/usr/lib/jvm/java-21-openjdk/bin/java",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dosgi.checkConfiguration=true",
					"-Dosgi.sharedConfiguration.area=" .. jdtls_path .. "/" .. config_dir,
					"-Dosgi.sharedConfiguration.area.readOnly=true",
					"-Dosgi.configuration.cascaded=true",
					"-Xms1G",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-Declipse.log.level=ALL", -- Log everything from Eclipse
					"-Dosgi.debug=true", -- Enable OSGi debugging
					"-Declipse.debug=true", -- Enable Eclipse platform debugging
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
					require("jdtls.setup").add_commands()
					jdtls.setup_dap({
						hotcodereplace = "auto",
						config_overrides = {},
					})
					-- .add_commands()
					-- require("jdtls.dap").setup_dap_main_class_configs()

					-- Keymappings for debugging
					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
					end

					map("n", "<leader>db", require("dap").toggle_breakpoint, "Debug: Toggle Breakpoint")
					map("n", "<leader>ds", require("dap").continue, "Debug: Start/Continue")
					map("n", "<leader>dc", require("dapui").close, "Close Debug UI")
					map("n", "<F11>", require("dap").step_over, "Debug: Step Over")
					map("n", "<F12>", require("dap").step_into, "Debug: Step Into")
				end,
			}
			-- Start the server
			jdtls.start_or_attach(config)
		end,
	},
}
