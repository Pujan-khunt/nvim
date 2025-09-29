local detail = false

return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	lazy = false,
	opts = {
		default_file_explorer = true, -- Hijack Netrw
		columns = {
			"icon",
			"lsp",
		},
		win_options = {
			signcolumn = "yes",
			wrap = true,
		},
		delete_to_trash = true,
		skip_confirm_for_simple_edits = false,
		prompt_save_on_select_new_entry = true,
		watch_for_changes = true, -- Watches for filesystem changes and updates
		keymaps = {
			["l"] = {
				desc = "Select current entry",
				callback = function()
					local oil = require("oil")
					local childPath = oil.get_current_dir() .. oil.get_cursor_entry().name
					oil.open(childPath)
					vim.cmd("cd " .. childPath)
				end,
			},
			["h"] = {
				desc = "Select current entry",
				callback = function()
					local oil = require("oil")
					oil.open()
					vim.cmd("cd " .. oil.get_current_dir())
				end,
			},
			["<C-h>"] = {}, -- Disable the normal functioning of <C-h>. <C-h> is used for transitioning to the left window in neovim.
			["<C-M-m>"] = "actions.preview",
			["gd"] = {
				desc = "Toggle file detail view",
				callback = function()
					detail = not detail
					if detail then
						require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
					else
						require("oil").set_columns({ "icon" })
					end
				end,
			},
		},
		lsp_file_methods = {
			enabled = true,
			timeout_ms = 1000,
		},
	},
}
