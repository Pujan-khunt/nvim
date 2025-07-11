-- Open the file explorer
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "Open File Explorer" })

-- Move Lines ( Cant live without this )
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Selected Lines Up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Selected Lines Down" })

-- Keep cursor in middle while jumping up and down with C-d and C-u
vim.keymap.set("n", "<c-j>", "<C-d>zz", { desc = "Maintain Cursor In Middle While Jumping Down", noremap = true })
vim.keymap.set("n", "<c-k>", "<C-u>zz", { desc = "Maintain Cursor In Middle While Jumping Up", noremap = true })

-- Remap the Redo Command
vim.keymap.set("n", "U", vim.cmd.redo, { desc = "Redo" })

-- Simplify Navigating Windows
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to Bottom Window" })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to Top Window" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to Left Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to Right Window" })

-- Source a config file
vim.keymap.set("n", "<leader>ls", "<cmd>source %<CR>", { desc = "Source a file" })

-- Copy selected visual onto clipboard register(+)
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy Visual Onto Clipboard" })

-- Paste from clipboard register(+)
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste From Clipboard" })

-- Toggle Relative Line Numbering
vim.keymap.set("n", "<leader>lr", function()
  vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle Relative Line Numbers" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left in visual mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right in visual mode" })

-- Close window
vim.keymap.set("n", "<leader>q", function()
  vim.cmd("q")
end, { desc = "Close Current Window" })

-- Open Mason
-- vim.keymap.set("n", "<leader>lm", function()
--   vim.cmd("Mason")
-- end, { desc = "Open Mason" })

-- Open LspInfo window
-- vim.keymap.set("n", "<leader>ll", function()
--   vim.cmd("LspInfo")
-- end, { desc = "Open LspInfo" })

