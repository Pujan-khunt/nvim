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
				},
			},
		},
	},
	on_attach = function(_, bufnr)
		local function map(mode, keybind, command, description)
			vim.keymap.set(mode, keybind, command, { desc = description, buffer = bufnr })
		end

		map("n", "<leader>jv", jdtls.extract_variable, "Java: Extract Variable")
		map("n", "<leader>jc", jdtls.extract_constant, "Java: Extract Constant")
		map("v", "<leader>jm", jdtls.extract_method, "Java: Extract Method")
	end,
}

jdtls.start_or_attach(config)
