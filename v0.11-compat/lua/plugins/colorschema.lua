--- @module "lazy"
--- @type LazySpec
return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		variant = "auto",
		transparent = false,
		italic_comments = true,

		overrides = function(colors)
			return {
				-- Builtins: len, make, append, etc.
				goBuiltins = { fg = colors.cyan, bold = false },
				["@function.builtin"] = { fg = colors.cyan, bold = false },

				-- Booleans: true, false
				goBoolean = { fg = colors.cyan, bold = false },
				["@boolean"] = { fg = colors.cyan, bold = false },

				-- Constants: nil, iota
				["@constant.builtin"] = { fg = colors.cyan, bold = false },

				-- This targets built-in variables like false, false, nil, iota
				["@lsp.typemod.variable.defaultLibrary"] = { fg = colors.cyan, bold = false },
				-- This targets built-in functions like len, make, append
				["@lsp.typemod.function.defaultLibrary"] = { fg = colors.cyan, bold = false },
				-- Some versions of gopls might use this for constants
				["@lsp.typemod.variable.readonly"] = { fg = colors.cyan, bold = false },
			}
		end,
	},
}
