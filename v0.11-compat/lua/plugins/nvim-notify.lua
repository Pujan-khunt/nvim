--- @module "lazy"
--- @type LazySpec
return {
	"rcarriga/nvim-notify",
	init = function()
		vim.notify = require("notify")
	end,
	--- @module "notify"
	--- @type notify.Config
	opts = {
		timeout = 2000,
		merge_duplicates = 1,
		render = "compact",
	},
}
