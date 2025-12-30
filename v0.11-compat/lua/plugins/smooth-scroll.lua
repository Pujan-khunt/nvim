return {
  "karb94/neoscroll.nvim",
  keys = {
    {
      "<C-k>",
      function()
        require("neoscroll").scroll(-0.5, {
          move_cursor = true,
          duration = 420,
          easing = "cubic",
          winid = vim.api.nvim_get_current_win(),
        })
      end,
      desc = "Smooth scroll up"
    },
    {
      "<C-j>",
      function()
        require("neoscroll").scroll(0.5, {
          move_cursor = true,
          duration = 420,
          easing = "cubic",
          winid = vim.api.nvim_get_current_win(),
        })
      end,
      desc = "Smooth scroll down"
    },
  },
  opts = { 
    mappings = { "zz" },
    -- performance mode breaks with nvim-treesitter rewrite
    -- performance_mode = true
  }
}
