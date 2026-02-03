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

-- Open NetRW
map("n", "<leader>e", vim.cmd.Oil, { desc = "Open NetRW" })

-- Open Lazy UI
map("n", "<leader>ol", vim.cmd.Lazy, { desc = "Open NetRW" })

-- Close current (active) window
map({ "n", "v", "x" }, "<leader>q", vim.cmd.q, { desc = "Close current window" })

-- Create window splits
map("n", "<leader>v", vim.cmd.vsplit, { desc = "Create vertical split" })
map("n", "<leader>h", vim.cmd.split, { desc = "Create horizontal split" })

-- Navigate back and forth across folds
map({ "n", "v" }, "[[", "zk%", { desc = "Goto start of previous fold" })
map({ "n", "v" }, "]]", "zj", { desc = "Goto start of next fold" })

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

-- Source entire file or current selection
map({ "n", "v" }, "<leader>sf", function()
	local filepath = vim.api.nvim_buf_get_name(0)
	local extension = vim.fn.fnamemodify(filepath, ":e")
	local basename = vim.fn.fnamemodify(filepath, ":t")

	-- Only source files which are sourcable (.vim and .lua).
	if extension == "vim" or extension == "lua" then
		-- All possible outputs:
		-- '^V': Visual Block
		-- 'V' : Visual Line
		-- 'v' : Visual
		-- 'n' : normal
		local mode = vim.api.nvim_get_mode().mode
		local source_command = "source " .. filepath
		local notify_message = ""

		if mode ~= "n" then
			-- Retrieve positions of the selection
			-- getpos() returns [ bufnr, line_number, column, offset ]
			local start_pos = vim.fn.getpos("v")
			local end_pos = vim.fn.getpos(".")

			-- Source partially (backwards range compatible)
			-- lua is 1-indexed, I am an absolute idiot
			local start_line = math.min(start_pos[2], end_pos[2])
			local end_line = math.max(start_pos[2], end_pos[2])

			-- Partial sourcing syntax: <line_start>,<line_end>source
			source_command = start_line .. "," .. end_line .. "source"

			notify_message = "Selection sourced from line " .. start_line .. " to line " .. end_line .. "."
		else
			notify_message = "File sourced: " .. basename
		end

		-- Run the source command
		vim.cmd(source_command)
		vim.notify(notify_message, vim.log.levels.INFO)
	else
		vim.notify("File cannot be sourced: " .. basename, vim.log.levels.ERROR)
	end
end, { desc = "Source selection/file" })

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

-- map("n", "<Esc><Esc>", "<Esc><Esc>", { desc = "Disable opencode double-escape trigger" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Disable opencode double-escape trigger" })

-- TODO: Backspace using a Control + ? in commmandline
-- TODO: Scroll up and down while treesitter mode is active in search(commandline)
-- TODO: Create the 'n' modifier or whatever it is called to be used for the next node/occurence. Eg. cin" will c-change i-inner n-next "-double-quote, this should wipe the contents of the next double quotes

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
