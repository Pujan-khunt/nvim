--- @module "lazy"
--- @type LazySpec
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		picker = {
			enabled = true,
			layout = {
				preset = "ivy",
			},
		},
		input = {
			enabled = true,
		},
		notifier = { enabled = true },
	},
	init = function()
		-- This connects Snacks to Neovim's standard UI interfaces
		-- It makes `vim.ui.select` (code actions) and `vim.ui.input` (renames) use Snacks
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.select = function(...)
			return require("snacks").picker.select(...)
		end
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.input = function(...)
			return require("snacks").input(...)
		end
	end,
}
