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
    },

    {
      "<leader>fk",
      mode = { "n" },
      function()
        local current_file = vim.api.nvim_buf_get_name(0)

        if current_file == "" or vim.fn.filereadable(current_file) == 0 then
          vim.notify("Not a valid file, skipping file history", vim.log.levels.WARN)
          return
        end

        vim.cmd(string.format("DiffviewFileHistory %s", vim.fn.fnameescape(current_file)))
      end,
      desc = "View file history for current file using Diffview"
    }
  },
  opts = {}
}
