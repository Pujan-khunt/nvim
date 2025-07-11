return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      scroll_strategy = "limit", -- Limit if tried to scroll past the start or end of the list
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      -- prompt_prefix = "🔎 ",
      selection_caret = "→ ",
      initial_mode = "insert",
      hidden = true,
      file_ignore_patterns = {
        "^%.git"
      },
      mappings = {
        i = {
          ["<M-k>"] = "move_selection_previous",
          ["<M-j>"] = "move_selection_next",
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      frecency = {
        show_scores = true,
        show_unindexed = false,
        ignore_patterns = { "*.git/*", "node_modules/*" },
      },
    },
    pickers = {
    }
  },
  -- Setting Telescope Specific Keymaps
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)

    local builtin = require("telescope.builtin")
    local config_dir = "$HOME/.config/nvim/"
    local cwd = vim.fn.getcwd()

    -- Find files using grep in the cwd.
    vim.keymap.set("n", "<leader>fg", function() builtin.live_grep({ cwd = cwd }) end,
      { desc = "Live Grep - Telescope" })

    -- Find files using grep in neovim config dir.
    vim.keymap.set("n", "<leader>fcg", function() builtin.live_grep({ cwd = config_dir }) end,
      { desc = "Live Grep - Telescope" })

    -- Find files based on the word under the cursor.
    vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Grep String Under Cursor - Telescope" })

    -- Find files in the cwd.
    vim.keymap.set("n", "<leader>fd", function() builtin.find_files({ cwd = cwd, hidden = true }) end,
      { desc = "Find Files in CWD - Telescope" })

    -- Find files in the neovim config dir.
    vim.keymap.set("n", "<leader>fcf",
      function() builtin.find_files({ cwd = config_dir, hidden = true, no_ignore = false }) end,
      { desc = "Find Files in Config - Telescope" })

    -- Show diffs of each file of git
    vim.keymap.set("n", "<leader>fv", builtin.git_status,
      { desc = "Show Diffs For Each File of Git - Telescope" })

    -- Fuzzy search through the previous commands entered on the command line, like :w or :vert h telescope
    -- TIP: Press <C-e> while hovering over command to populate the command line with it.
    -- Pressing enter on currently hovered node will execute that command.
    vim.keymap.set("n", "<leader>fch", builtin.command_history,
      { desc = "Fuzzy Search Command History - Telescope" })

    -- Fuzzy search quick fix list
    -- TIP: To convert telescope list to quick fix list, press <C-q>
    vim.keymap.set("n", "<leader>fq", builtin.quickfix,
      { desc = "Convert Quickfix List to Fuzzy Search it - Telescope" })

    -- Fuzzy search highlights
    vim.keymap.set("n", "<leader>fhl", builtin.highlights, { desc = "Fuzzy Search Highlights - Telescope" })

    -- Fuzzy search help tags like telescope.builtins etc.
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Fuzzy Search Help Pages - Telescope" })

    -- Fuzzy search man pages
    vim.keymap.set("n", "<leader>fmp", builtin.man_pages, { desc = "Fuzzy Search Man Pages - Telescope" })

    -- Resume to the previously opened telescope window with the same state(prompt)
    vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume in Previous State - Telescope" })

    -- Visualize Register Content
    -- Overriden by folke/which-key
    -- vim.keymap.set("n", "<C-r>", builtin.registers, { desc = "View Register Content - Telescope" });
  end,
}
