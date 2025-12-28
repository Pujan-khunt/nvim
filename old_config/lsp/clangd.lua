-- This file configures the clangd language server.
-- It follows the structure of the other LSP configurations provided.

local blink = require("blink.cmp")
local on_attach = require("config.globals")

return {
	-- The on_attach function is called when the LSP client attaches to a buffer.
	-- This is a good place to set keymaps specific to LSP features.
	on_attach = on_attach,

	-- The command to start the clangd language server.
	-- The 'clangd.path' and 'clangd.arguments' from your schema are configured here.
	cmd = {
		"clangd", -- This corresponds to 'clangd.path'.
		"--offset-encoding=utf-16", -- Recommended for compatibility with Neovim.
		-- You can add more command-line arguments from the 'clangd.arguments' schema here.
		-- Example: "--log=error", "--query-driver=/usr/bin/g++"
	},

	-- Filetypes that clangd should activate for.
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "zig" },

	-- Markers that indicate the root of a project.
	-- Clangd will search upwards from the current file for these.
	root_markers = {
		"compile_commands.json",
		"compile_flags.txt",
		".clang-format",
		".clang-tidy",
		".clangd",
		".git",
	},

	-- Initialization options are sent to the server when it starts.
	-- This is where most server-specific settings are configured.
	init_options = {
		-- Fallback compiler flags to use when 'compile_commands.json' is not found.
		-- This is useful for projects without a build system or for editing header files.
		-- This corresponds to the 'clangd.fallbackFlags' setting from your schema.
		-- fallbackFlags = { "-std=c++20", "-I/usr/include" },

		-- Configure how inactive code regions (e.g., code inside '#if 0') are displayed.
		-- This corresponds to the 'clangd.inactiveRegions' settings from your schema.
		inactiveRegions = {
			opacity = 0.55,
			useBackgroundHighlight = false,
		},

		-- NOTE: The following settings from your schema are handled by the editor/client,
		-- not the clangd server, and are therefore not included here:
		-- 'checkUpdates', 'detectExtensionConflicts', 'enable', 'onConfigChanged',
		-- 'restartAfterCrash', 'semanticHighlighting', 'serverCompletionRanking'.

		-- ======================================================================
		-- Additional useful clangd settings (uncomment and configure as needed)
		-- ======================================================================

		-- Specify a path to a directory containing 'compile_commands.json'.
		-- compilationDatabasePath = "build",

		-- Configure inlay hints for parameter names, deduced types, etc.
		-- inlayHints = {
		--   -- Enable specific hints. Available: 'parameterNames', 'deducedTypes', 'designators'.
		--   enabled = { "parameterNames", "deducedTypes" },
		-- },
	},

	-- Client capabilities are advertised to the server to signal what LSP features are supported.
	-- Here, we merge the default capabilities with those provided by nvim-cmp.
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink.get_lsp_capabilities()
	),
}
