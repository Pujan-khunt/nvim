local on_attach = require("config.globals")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = "/home/pujan/.cache/jdtls-workspace/" .. project_name
local capabilities = vim.tbl_deep_extend(
	"force",
	vim.lsp.protocol.make_client_capabilities(),
	require("blink.cmp").get_lsp_capabilities()
)

return {
	on_attach = on_attach,

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

	filetypes = {
		"java",
	},

	root_markers = { ".git", "pom.xml", "mvnw", "gradlew" },

	settings = {
		java = {
			-- Enable/disable all Java features.
			-- If you want to temporarily disable jdtls without uninstalling it,
			-- you can just set this to false.
			-- Type: boolean
			-- Default: true
			enabled = true,

			--======================================================================
			-- FORMATTING
			--======================================================================
			format = {
				-- Enable/disable the default Java formatter.
				-- Type: boolean
				-- Default: true
				enabled = true,

				-- Configure detailed formatter settings.
				settings = {
					-- The profile determines the overall code style.
					-- Common options: "GoogleStyle", "Eclipse [built-in]", etc.
					-- You can define custom profiles via the 'url' setting below.
					-- "GoogleStyle" is a popular, modern choice.
					-- Type: string
					-- profile = "Eclipse [built-in]",
					profile = "JavaConventions",

					-- URL or file path to a custom Eclipse formatter XML file.
					-- Use this if you have a team-wide style guide.
					-- Type: string (path or URL)
					-- Default: nil
					-- url = nil
					url = "/home/pujan/.config/java_formatter/eclipse_format_settings.xml",
				},

				-- Whether to format comments.
				-- Type: boolean
				-- Default: true
				comments = {
					enabled = true,
				},

				-- Whether to insert spaces for tabs. Most modern style guides recommend this.
				-- Type: boolean
				-- Default: true
				insertSpaces = false,

				-- The number of spaces to use for an indent or a tab.
				-- Type: integer
				-- Default: 4
				tabSize = 4,
			},

			--======================================================================
			-- SAVE ACTIONS & IMPORTS
			--======================================================================
			saveActions = {
				-- Automatically organize imports on save. This is a huge time-saver.
				-- Type: boolean
				-- Default: false
				organizeImports = true,
			},
			sources = {
				organizeImports = {
					-- How many imports in a package are needed before using a wildcard (e.g., `import java.util.*`).
					-- Setting this to a high number encourages explicit imports, which is often clearer.
					-- Type: integer
					-- Default: 99
					starThreshold = 99,

					-- Same as above, but for static imports.
					-- Type: integer
					-- Default: 99
					staticStarThreshold = 99,
				},
			},
			-- The order in which imports should be grouped by the "Organize Imports" action.
			-- This is a sensible default order.
			-- Type: array of strings
			-- import = {
			-- 	order = {
			-- 		"java",
			-- 		"javax",
			-- 		"org",
			-- 		"com",
			-- 		"#", -- Special character for all static imports
			-- 	},
			-- },

			--======================================================================
			-- CODE COMPLETION & INTELLISENSE
			--======================================================================
			completion = {
				-- Enable/disable all completion features.
				-- Type: boolean
				-- Default: true
				enabled = true,

				-- Enable/disable postfix completion (e.g., typing `myList.for` and having it expand).
				-- Type: boolean
				-- Default: true
				postfix = {
					enabled = true,
				},

				-- Enable/disable chain completion (e.g., completing a series of method calls).
				-- Type: boolean
				-- Default: false
				chain = {
					enabled = true,
				},

				-- Whether completion should overwrite the text ahead of the cursor or insert.
				-- 'true' is the standard behavior in most IDEs.
				-- Type: boolean
				-- Default: true
				overwrite = true,

				-- Automatically add imports for completed items.
				-- Type: boolean
				-- Default: true
				import = {
					enabled = true,
				},

				-- Suggest method arguments after completing a method call.
				-- 'insertBestGuessedArguments': Smartly guesses arguments based on context.
				-- 'insertParameterNames': Fills in placeholder names for arguments.
				-- 'disabled': Inserts only the parentheses.
				-- Type: string
				-- Default: 'insertParameterNames'
				guessMethodArguments = "insertBestGuessedArguments",

				-- A list of static members to show in completion suggestions, even if not yet imported.
				-- Great for testing libraries like JUnit, AssertJ, etc.
				-- Type: array of strings
				favoriteStaticMembers = {
					"org.junit.Assert.*",
					"org.junit.Assume.*",
					"org.junit.jupiter.api.Assertions.*",
					"org.junit.jupiter.api.Assumptions.*",
					"org.junit.jupiter.api.DynamicContainer.*",
					"org.junit.jupiter.api.DynamicTest.*",
					"org.assertj.core.api.Assertions.*",
					"org.mockito.Mockito.*",
				},

				-- Types to exclude from completion and import suggestions.
				-- Good for filtering out legacy or internal packages.
				-- Type: array of strings
				filteredTypes = {
					"java.awt.*",
					"com.sun.*",
					"sun.*",
					"jdk.*",
					"org.graalvm.*",
					"io.micrometer.shaded.*",
				},
			},

			--======================================================================
			-- CODE ANALYSIS & DIAGNOSTICS
			--======================================================================
			-- Configure the severity of various compiler warnings and errors.
			-- Possible values: "ignore", "info", "warning", "error"
			compile = {
				-- Enable annotation-based null analysis using annotations like @NonNull.
				-- 'disabled': Off completely.
				-- 'interactive': Prompts you to enable it if it finds nullness annotations.
				-- 'automatic': Enables it automatically if annotations are detected.
				-- 'interactive' is a safe and smart default.
				nullAnalysis = {
					mode = "interactive",
				},
				-- This setting is now preferred over the older `maven.errors.notCoveredPluginExecution`
				maven = {
					defaultMojoExecutionAction = "warn", -- Warn about unhandled Maven plugin executions
				},
			},

			-- Configure how quick fixes are displayed.
			-- 'line': Show a single quick fix action on the line with the problem. (Recommended)
			-- 'problem': Show quick fixes grouped under each specific problem.
			-- Type: string
			quickfix = {
				showAt = "line",
			},

			--======================================================================
			-- CODE GENERATION
			--======================================================================
			codeGeneration = {
				-- When generating hashCode() and equals(), use Objects.hash() and Objects.equals().
				-- This requires Java 7+ and is the modern, recommended approach.
				-- Type: boolean
				-- Default: false
				hashCodeEquals = {
					useJava7Objects = true,
				},

				-- When generating methods (getters, setters, etc.), add comments.
				-- Can be verbose, so it's often disabled.
				-- Type: boolean
				-- Default: false
				generateComments = false,

				-- Configure the toString() source action.
				toString = {
					-- The template to use for generation.
					template = "${object.className} [${member.name()}=${member.value}, ${otherMembers}]",
					-- The style of code to generate.
					codeStyle = "STRING_BUILDER",
					-- Avoid checking for nulls in the generated code.
					skipNullValues = false,
					-- Also list the contents of arrays.
					listArrayContents = true,
				},
			},

			--======================================================================
			-- CODE LENSES & HINTS
			--======================================================================
			-- Code Lenses are the small, clickable text annotations that appear above methods/classes.
			-- Enable/disable the Code Lens that shows the number of references to a method or class.
			-- Type: boolean
			-- Default: true
			referencesCodeLens = {
				enabled = true,
			},

			-- Enable/disable the Code Lens that provides navigation to implementations and superclasses.
			-- Type: boolean
			-- Default: false
			implementationCodeLens = {
				enabled = true,
			},

			-- Configure inlay hints, which show parameter names for method calls.
			inlayHints = {
				parameterNames = {
					-- 'none': Disabled.
					-- 'literals': Show hints only for literal arguments (e.g., `myMethod(true, "hello")`).
					-- 'all': Show hints for all arguments.
					-- 'literals' is a good balance between helpfulness and visual noise.
					enabled = "literals",
				},
			},

			--======================================================================
			-- BUILD & PROJECT MANAGEMENT
			--======================================================================
			-- How to handle build configuration updates when build files (pom.xml, build.gradle) change.
			-- 'interactive': Prompt for each change. (Safe default)
			-- 'automatic': Automatically update without prompting.
			-- 'disabled': Do nothing.
			configuration = {
				updateBuildConfiguration = "interactive",
				-- Your existing runtime configuration
				runtimes = {
					{
						name = "JavaSE-25",
						path = "/usr/lib/jvm/java-25-openjdk/",
						default = true,
					},
					{
						name = "JavaSE-21",
						path = "/usr/lib/jvm/java-21-openjdk/",
					},
				},
			},

			-- Enable/disable the Gradle importer.
			-- Type: boolean
			-- Default: true
			import = {
				gradle = {
					enabled = true,
					wrapper = {
						enabled = true, -- Use the gradle wrapper if present
					},
				},
				-- Enable/disable the Maven importer.
				-- Type: boolean
				-- Default: true
				maven = {
					enabled = true,
				},
			},

			-- For Maven projects, automatically download source JARs for dependencies.
			-- This is essential for features like "Go to Definition" on library code.
			-- Type: boolean
			-- Default: false
			maven = {
				downloadSources = true,
			},

			-- For Eclipse projects, automatically download source JARs for dependencies.
			-- Type: boolean
			-- Default: false
			eclipse = {
				downloadSources = true,
			},

			--======================================================================
			-- MISCELLANEOUS
			--======================================================================
			-- Search scope for symbols and references.
			-- 'all': Search both main and test sources.
			-- 'main': Search only main sources.
			search = {
				scope = "all",
			},

			-- Include method declarations from source files in workspace symbol search.
			-- Set to true if you want `Workspace Symbols` to include methods, not just classes.
			-- Can impact performance on very large projects.
			symbols = {
				includeSourceMethodDeclarations = true,
			},

			-- When finding references, also find references to getters/setters.
			-- Type: boolean
			-- Default: true
			references = {
				includeAccessors = true,
				-- Also search for references inside decompiled library code.
				includeDecompiledSources = true,
			},

			-- Enable content providers from third-party extensions.
			-- For example, if you install the vscode-java-decompiler extension,
			-- this setting must be enabled to allow it to decompile class files.
			contentProvider = {
				preferred = "decompiler", -- or other providers like 'fernflower'
			},

			-- To see this in action you can add the following to your jdtls init_options
			-- init_options = {
			--    bundles = {
			--        vim.fn.glob(
			--           "/path/to/vscode-java-decompiler/server/com.microsoft.java.decompiler-*.jar"
			--        )
			--    }
			-- }
		},
	},

	capabilities = capabilities,

	init_options = {
		bundles = {},
	},
}
