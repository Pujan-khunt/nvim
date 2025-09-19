-- lua/plugins/jdtls.lua

return {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local on_attach = require("config.globals")

		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("blink.cmp").get_lsp_capabilities()
		)

		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = "/home/pujan/.cache/jdtls-workspace/" .. project_name

		-- This is the configuration table that nvim-jdtls will use to start the server.
		local config = {
			-- ❗️ CRITICAL FIX: REMOVED the entire 'cmd' table.
			-- Instead, we tell the plugin where to find Java.
			-- The plugin will now build the entire command for us.
			java_home = "/usr/lib/jvm/java-25-openjdk/",

			cmd = {
				"/usr/lib/jvm/java-25-openjdk/bin/java",
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xms1g",

				-- Java 25 features
				"--enable-preview",
				"--add-modules=ALL-SYSTEM",

				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",

				"-jar",
				"/home/pujan/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar",

				"-configuration",
				"/home/pujan/.local/share/nvim/mason/packages/jdtls/config_linux/",

				"-data",
				workspace_dir,
			},

			-- The plugin will automatically find the project root.
			root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

			-- Your custom settings for the server
			settings = {
				java = {
					format = {
						enabled = true,
						settings = {
							profile = "GoogleStyle",
						},
					},
					configuration = {
						runtimes = {
							{
								name = "JavaSE-25",
								path = "/usr/lib/jvm/java-25-openjdk/",
								default = true,
							},
						},
					},
				},
			},

			-- Attach your custom keymaps and capabilities
			on_attach = on_attach,
			capabilities = capabilities,
		}

		-- This starts the server and attaches it to the buffer
		require("jdtls").start_or_attach(config)
	end,
}
