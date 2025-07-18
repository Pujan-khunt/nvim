return {
	"3rd/image.nvim",
	opts = {
		backend = "ueberzug",
	},
	config = function(_, opts)
		local image = require("image")

		image.setup(opts)
	end,
}
