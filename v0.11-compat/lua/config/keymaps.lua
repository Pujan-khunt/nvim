local map = vim.keymap.set

-- Quit everything forcefully.
map("n", "<C-q>", "<cmd>qa!<cr>", { desc = "Quit All" })

-- Move lines(selection) up and down.
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection down" })

-- Persist selection while indenting
map("x", ">", ">gv", { desc = "Indent right (persistent selection)" })
map("x", "<", "<gv", { desc = "Indent left (persistent selection)" })

-- Open Oil
map("n", "<leader>e", vim.cmd.Oil, { desc = "Open Oil" })

-- Open Lazy UI
map("n", "<leader>ll", vim.cmd.Lazy, { desc = "Open Lazy" })
map("n", "<leader>lm", vim.cmd.Mason, { desc = "Open Mason" })

-- Close current (active) window
map({ "n", "v", "x" }, "<leader>q", vim.cmd.q, { desc = "Close current window" })

-- Create window splits
map("n", "<leader>v", vim.cmd.vsplit, { desc = "Create vertical split" })
map("n", "<leader>h", vim.cmd.split, { desc = "Create horizontal split" })

-- Open and close folds easily
map({ "n", "v" }, "H", "zc", { desc = "Close fold under the cursor" })
map({ "n", "v" }, "L", "zo", { desc = "Open fold under the cursor" })

-- Copy contents into clipboard
map({ "v" }, "<leader>y", '"+y', { desc = "Copy selection into clipboard" })

-- Cut contents into clipboard
map({ "x" }, "<leader>d", '"+d', { desc = "Cut selection into clipboard" })

-- Paste contents from clipboard
map({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- Remap redo to Shift + U
map("n", "<S-u>", "<C-r>", { desc = "Redo" })

map("n", "m", "s", { desc = "Delete + goto insert mode" })
map("n", "'", "/", { desc = "Delete + goto insert mode" })

-- Scroll using vim motions while keeping things centered.
map({ "n", "t", "v" }, "<C-j>", "<C-d>zz", { desc = "Scroll Down (centered)" })
map({ "n", "t", "v" }, "<C-k>", "<C-u>zz", { desc = "Scroll Up (centered)" })

-- Easier lsp debugging
map("n", "<leader>dl", "<cmd>checkhealth vim.lsp<CR>", { desc = "Check vim.lsp health" })

-- Navigate to the left window easily
map({ "n", "t" }, "<C-h>", "<cmd>wincmd h<CR>", { desc = "Navigate to left window" })
map({ "n", "t" }, "<C-l>", "<cmd>wincmd l<CR>", { desc = "Navigate to right window" })

map("n", "<C-n>", "<cmd>cnext<CR>", { desc = "Navigate to next quickfix list item" })
map("n", "<C-p>", "<cmd>cprevious<CR>", { desc = "Navigate to previous quickfix list item" })
map("n", "<C-y>", function()
	if vim.g.quickfix_enabled == 1 then
		vim.g.quickfix_enabled = 0
		vim.cmd("cclose")
	else
		vim.g.quickfix_enabled = 1
		vim.cmd("copen")
	end
end)

map({ "n", "v" }, "<leader>cl", vim.lsp.codelens.run, { desc = "Open codelens" })
