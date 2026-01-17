-- Currently this configuration is not in use in favour for nvim-jdtls plugin.
local JDTLS_LOCATION = os.getenv("HOME") .. "/Downloads/jdtls/"

-- System detection
local system = vim.uv.os_uname().sysname
local config_dir = ""
if system == "Linux" then
	config_dir = "config_linux"
elseif system == "Darwin" then
	config_dir = "config_mac"
elseif system == "Windows_NT" then
	config_dir = "config_win"
end

-- Finding Equinox launcher JAR
local launcher_pattern = JDTLS_LOCATION .. "/plugins/org.eclipse.equinox.launcher_*.jar"
local launcher_jar = vim.fn.glob(launcher_pattern)

-- Merge LSP capabilities with blink.cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_blink, blink = pcall(require, "blink.cmp")
if has_blink then
	vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
end

-- Extended Client Capabilities
local extendedClientCapabilities = {
	progressReportProvider = true,
	classFileContentsSupport = true,
	generateToStringPromptSupport = true,
	hashCodeEqualsPromptSupport = true,
	advancedExtractRefactoringSupport = true,
	advancedOrganizeImportsSupport = true,
}

if launcher_jar == "" then
	vim.notify("Could not find JDTLS launcher JAR at: " .. launcher_pattern, vim.log.levels.ERROR)
end

--- https://github.com/eclipse-jdtls/eclipse.jdt.ls
--- @type vim.lsp.Config
return {
	-- Command and arguments to run the Java language server
	cmd = function(dispatchers, config)
		local root_dir = config.root_dir
		---@diagnostic disable-next-line: param-type-mismatch
		local project_name = vim.fn.fnamemodify(root_dir, ":t")
		---@diagnostic disable-next-line: param-type-mismatch
		local workspace_hash = vim.fn.sha256(root_dir):sub(1, 16)
		local data_dir = os.getenv("HOME") .. "/.cache/jdtls/workspace/" .. project_name .. "_" .. workspace_hash

		local cmd_args = {
			"java",
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dosgi.checkConfiguration=true",
			"-Dosgi.sharedConfiguration.area=" .. JDTLS_LOCATION .. "/" .. config_dir,
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
			data_dir,
		}

		return vim.lsp.rpc.start(cmd_args, dispatchers)
	end,

	-- Filetypes in neovim to automatically attach to
	filetypes = { "java" },

	-- Files that share the same root directory will reuse the LSP server connection
	-- Nested lists indicate equal priority
	root_markers = {
		{ "pom.xml", "build.gradle", "build.gradle.kts" },
		".git",
	},

	capabilities = capabilities,

	init_options = {
		extendedClientCapabilities = extendedClientCapabilities,
	},

	settings = {
		java = {
			format = {
				enabled = true,
				settings = {
					url = vim.fn.expand("~/.config/nvim/lang-servers/intellij-java-google-style.xml"),
					profile = "GoogleStyle",
				},
			},
			saveActions = {
				organizeImports = true,
			},

			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				hashCodeEquals = {
					useJava7Objects = true,
				},
				useBlocks = true,
			},

			eclipse = {
				downloadSources = true,
			},
			maven = {
				downloadSources = true,
			},

			references = {
				includeAccessors = true,
				includeDecompiledSources = true,
			},
			symbols = {
				includeSourceMethodDeclarations = true,
			},
			search = {
				scope = "all",
			},

			inlayHints = {
				parameterNames = {
					enabled = "all",
				},
			},

			contentProvider = {
				preferred = "fernflower",
			},

			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},

			completion = {
				postfix = {
					enabled = true,
				},
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.stream.Collectors.*",
					"org.mockito.Mockito.*",
				},
				importOrder = {
					"java",
					"javax",
					"com",
					"org",
				},
			},
		},
	},
}
