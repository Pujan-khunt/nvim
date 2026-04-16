--- @module "lazy"
--- @type LazySpec
return {
	"altermo/ultimate-autopair.nvim",
	enabled = function()
		local bufname = vim.api.nvim_buf_get_name(0)
		return not vim.startswith(bufname, "oil")
	end,
	event = { "InsertEnter", "CmdlineEnter" },
	branch = "v0.6",
	opts = {
		fastwarp = {
			map = "<C-l>",
			rmap = "<C-h>",
			cmap = "<C-l>",
			rcmap = "<C-h>",
		},
	},
}
