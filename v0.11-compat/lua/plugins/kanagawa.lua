--- @module "lazy"
--- @type LazySpec
return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	--- @module "kanagawa"
	--- @type KanagawaConfig
	opts = {
		-- NOTE: When 'true' the following command needs to be run everytime this config file is changed.
		-- `<cmd>KanagawaCompile<CR>`
		compile = true,
		colors = {
			theme = {
				all = {
					ui = {
						bg_gutter = "none",
					},
				},
			},
		},
		overrides = function(colors)
			local theme = colors.theme
			return {
				NormalFloat = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none" },

				-- Save an hlgroup with dark background and dimmed foreground
				-- so that you can use it where your still want darker windows.
				-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
				NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

				-- Popular plugins that open floats will link to NormalFloat by default;
				-- set their background accordingly if you wish to keep them dark and borderless
				LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
				MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
			}
		end,
	},
}
