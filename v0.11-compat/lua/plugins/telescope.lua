return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope", -- Lazy load based on this command.
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
    "<leader>ff", 
    function()
          require("telescope.builtin").find_files({ 
            cwd = vim.fn.getcwd(),
            hidden = true,
            follow = true -- Follow symlinks to edit the original file.
          })
    end, 
    desc = "Find files in current working directory" 
    },
    {
    "<leader>lg", 
    function()
          require("telescope.builtin").live_grep({ cwd = vim.fn.getcwd() })
    end, 
    desc = "Live grep in current working directory" 
    },
    {
     "<leader>fr",
     function()
      require("telescope.builtin").resume()
      end,
     desc = "Resume last opened picker"
    },
    {
     "<leader>fh",
     function()
      require("telescope.builtin").help_tags()
      end,
     desc = "Help tags picker"
    },
  },
  opts = {
	  defaults = {
		  dynamic_preview_title = true,

		  -- Classic.
		  results_title = "You can't spell advertisements without semen between the tits",

		  -- Ignore .env files to risk exposing secrets
		  -- Ignore node_modules and .git for obvious reasons
		  file_ignore_patterns = { "%.env", "^node_modules/", "^.git" },
      mappings = {
              i = {
                      ["<C-j>"] = "move_selection_next",
                      ["<C-k>"] = "move_selection_previous",
                      ["<C-v>"] = "file_vsplit",
                      ["<C-l>"] = "select_default",
              }
      }
    },
 }
}
