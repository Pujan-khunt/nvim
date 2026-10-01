--- @module "lazy"
--- @type LazySpec
return {
  "sindrets/diffview.nvim",
  lazy = false,
  keys = {
    {
      "<c-l>",
      mode = { "n" },
      "<cmd>DiffviewToggleFiles<CR>",
      desc = "Toggle File Explorer in Diffview",
    },
  },
  opts = {}
}
