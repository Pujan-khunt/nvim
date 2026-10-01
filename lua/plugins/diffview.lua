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
    {
      "<leader>dx",
      mode = { "n" },
      "<cmd>DiffviewClose<CR>",
      desc = "Close Diffview"
    },
    {
      "<leader>fj",
      mode = { "n" },
      "<cmd>DiffviewFileHistory<CR>",
      desc = "View file history for every commit using Diffview"
    }
  },
  opts = {}
}
