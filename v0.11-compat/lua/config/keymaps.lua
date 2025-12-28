local map = vim.keymap.set


-- Quit everything forcefully.
map("n", "<C-q>", "<cmd>qa!<cr>", { desc = "Quit All" })

-- Move lines(selection) up and down.
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection down" })

-- Persist selection while indenting
map("x", ">", ">gv", { desc = "Indent right (persistent selection)" })
map("x", "<", "<gv", { desc = "Indent left (persistent selection)" })

-- Keep cursor in the middle of the screen
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down + center cursor" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up + center cursor" })

-- Source currently opened file
map("n", "<leader>sf", "<cmd>source %<cr>", { desc = "Source current file" })

-- Open NetRW
map("n", "<leader>e", "<cmd>Ex<CR>", { desc = "Open NetRW" })

-- Open Lazy UI
map("n", "<leader>ol", "<cmd>Lazy<CR>", { desc = "Open NetRW" })

-- Close current (active) window
map({ "n", "v", "x" }, "<leader>q", "<cmd>q<CR>", { desc = "Close current window" })

-- Create window splits
map("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Create vertical split" })
map("n", "<leader>h", "<cmd>split<CR>", { desc = "Create horizontal split" })

-- Navigate back and forth across folds
map({ "n", "v" }, "[[", "zk%", { desc = "Goto start of previous fold" })
map({ "n", "v" }, "]]", "zj", { desc = "Goto start of next fold" })

map({ "n", "v" }, "H", "zc", { desc = "Close fold under the cursor" })
map({ "n", "v" }, "L", "zo", { desc = "Open fold under the cursor" })
