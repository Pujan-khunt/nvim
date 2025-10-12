-- Open the file explorer
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "Open File Explorer" })

-- Move Lines ( Cant live without this )
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Selected Lines Up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Selected Lines Down" })

-- Redo
vim.keymap.set("n", "U", vim.cmd.redo, { desc = "Redo" })

-- Simplify Navigating Windows
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to Bottom Window" })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to Top Window" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to Left Window" })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to Right Window" })

-- Source a config file
vim.keymap.set("n", "<leader>ls", "<cmd>source %<CR>", { desc = "Source a file" })

-- Copy selected visual onto clipboard register(+)
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy Visual Onto Clipboard" })

-- Paste from clipboard register(+)
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste From Clipboard" })

-- Toggle Relative Line Numbering
vim.keymap.set("n", "<leader>lr", function()
	vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle Relative Numbers" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left in visual mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right in visual mode" })

-- Resize windows 1x
vim.keymap.set("n", "<leader>.", "<C-w>>", { desc = "Resize Window Left" })
vim.keymap.set("n", "<leader>,", "<C-w><", { desc = "Resize Window Right" })

-- Resize windows 3x
vim.keymap.set("n", "<leader>.", "<C-w>><C-w>><C-w>>", { desc = "Resize Window Left" })
vim.keymap.set("n", "<leader>,", "<C-w><<C-w><<C-w><", { desc = "Resize Window Right" })

-- Close nvim
vim.keymap.set({ "n", "v" }, "<C-q>", "<cmd>qa!<CR>", { desc = "Close NeoVim" })

-- Close window
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Close Current Window" })

-- Open Diff View using diffview.nvim
vim.keymap.set("n", "<leader>ld", "<cmd>DiffviewOpen<CR>", { desc = "Open Git Diff View" })

-- Open Window for Lazy
vim.keymap.set("n", "<leader>lz", "<cmd>Lazy<CR>", { desc = "Open Lazy Page" })

-- Open LspInfo window
vim.keymap.set("n", "<leader>ll", "<cmd>LspInfo<CR>", { desc = "Open LspInfo" })

-- Format Buffer using conform.nvim
vim.keymap.set("n", "<leader>w", function()
	require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
end, { desc = "Format Buffer" })

-- Keymap to toggle lazygit
vim.keymap.set("n", "<leader>lg", function()
	require("snacks").lazygit()
end, { desc = "Toggle [L]azy[g]it" })

-- Format buffer using lsp
vim.keymap.set("n", "<leader>lf", function()
	-- require("conform").format({
	-- 	async = true,
	-- 	bufnr = 0,
	-- 	formatting_options = {
	-- 		tabSize = 4,
	-- 		insertSpaces = false,
	-- 		trimTrailingWhitespace = true,
	-- 		insertFinalNewline = true,
	-- 		trimFinalNewlines = true,
	-- 	},
	-- })
	vim.lsp.buf.format({
		async = true,
		formatting_options = {
			tabSize = 4,
			insertSpaces = false,
			trimTrailingWhitespace = true,
			insertFinalNewline = true,
			trimFinalNewlines = true,
		},
	})
end, { desc = "Format Buffer" })

vim.keymap.set("t", "<Esc><Esc", "<c-\\><c-n>", { noremap = true, silent = true, desc = "Normal from Terminal Mode" })

vim.keymap.set("n", "<leader>tn", "<cmd>TermNew<CR>", { desc = "Open New ToggleTerm " })
vim.keymap.set("n", "<leader>tt", "<cmd>TermSelect<CR>", { desc = "Select ToggleTerm " })
vim.keymap.set("n", "<leader>tr", "<cmd>ToggleTermSetName<CR>", { desc = "Set Terminal Name" })
