--- @module "lazy"
--- @type LazySpec
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>hg",
      "<cmd>Gitsigns<CR>",
      mode = { "n", "v" },
      desc = "Select Gitsigns Action",
    },
    {
      "=",
      function()
        require("gitsigns").preview_hunk_inline()
      end,
      mode = { "n" },
    },
    {
      "]h",
      function()
        require("gitsigns").nav_hunk("next")
        vim.cmd("normal! zz")
        require("gitsigns").preview_hunk_inline()
      end,
      mode = { "n" },
      desc = "Previous Git Hunk"
    },
    {
      "[h",
      function()
        require("gitsigns").nav_hunk("prev")
        vim.cmd("normal! zz")
        require("gitsigns").preview_hunk_inline()
      end,
      mode = { "n" },
      desc = "Next Git Hunk"
    },
  },
  opts = {},
}
