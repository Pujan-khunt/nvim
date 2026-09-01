--- Uses treesitter to autoclose and autorename html tags.
--- @module "lazy"
--- @type LazySpec
return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" },
	opts = {},
}
