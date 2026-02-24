-- Indentation
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true

local status, jdtls = pcall(require, "jdtls")
if not status then
	vim.notify("jdtls lua module not found. Not starting jdtls :(", vim.log.levels.WARN)
	return
end

-- Determine workspace directory
-- JDTLS requires a unique workspace directory for every project to prevent cache corruption
-- Hence this configuration needs to be run for every file (ftplugin/java.lua)
local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.local/share/nvim/jdtls-workspace/" .. project_name

-- Determine jdtls installation path
local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

-- Determine JDTLS launcher jar and config directory path
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_dir = jdtls_path .. "/config_linux"

local java_debug_adapter_path = vim.fn.stdpath("data")
	.. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
local java_debug_adapter = vim.fn.glob(java_debug_adapter_path, true)

local java_test_path = vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar"
local java_test = vim.fn.glob(java_test_path, true)

local bundles = {
	java_debug_adapter,
	java_test,
}

--- @type vim.lsp.Config
local config = {
	-- The command that starts the language server
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		launcher_jar,
		"-configuration",
		config_dir,
		"-data",
		workspace_dir,
	},
	root_dir = require("jdtls.setup").find_root({ ".git, mvnw, gradlew", "pom.xml", "build.gradle" }),
	init_options = {
		bundles = bundles,
	},
	settings = {
		java = {
			signatureHelp = { enabled = true },
			completion = {
				favoriteStaticMembers = {
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			configuration = {
				runtimes = {
					{
						name = "JavaSE-25",
						path = "/usr/lib/jvm/java-25-openjdk",
						default = true,
					},
					{
						name = "JavaSE-21",
						path = "/usr/lib/jvm/java-21-openjdk",
					},
				},
			},
			format = {
				enabled = true,
				settings = {
					url = vim.fn.stdpath("config") .. "/lua/config/eclipse-formatter.xml",
					profile = "GoogleStyle",
				},
			},
		},
	},
	on_attach = function(_, bufnr)
		local function map(mode, keybind, command, description)
			vim.keymap.set(mode, keybind, command, { desc = description, buffer = bufnr })
		end

		-- Extract keymaps
		map("n", "<leader>jv", jdtls.extract_variable, "Java: Extract Variable")
		map("n", "<leader>jc", jdtls.extract_constant, "Java: Extract Constant")
		map("v", "<leader>jm", jdtls.extract_method, "Java: Extract Method")

		-- Select symbols from current and parent
		map("n", "<leader>jj", jdtls.extended_symbols, "Java: Extended Symbols")

		jdtls.setup_dap({ hotcodereplace = "auto" })

		-- Debugging Keymaps
		local dap = require("dap")
		map("n", "<F5>", dap.continue, "Debug: Start/Continue")
		map("n", "<F10>", dap.step_over, "Debug: Step Over")
		map("n", "<F11>", dap.step_into, "Debug: Step Into")
		map("n", "<F12>", dap.step_out, "Debug: Step Out")
		map("n", "<leader>b", dap.toggle_breakpoint, "Debug: Toggle Breakpoint")
		map("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, "Debug: Conditional Breakpoint")

		-- Java Specific testing triggers
		map("n", "<leader>tc", jdtls.test_class, "Java: Test Class")
		map("n", "<leader>tm", jdtls.test_nearest_method, "Java: Test Method")
	end,
}

jdtls.start_or_attach(config)
