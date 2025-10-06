-- Indenting set to 2
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})

-- Leader key
vim.g.mapleader = " "

-- Line numbering
vim.opt.nu = true
vim.opt.relativenumber = true

-- Who doesn't want smart indenting
vim.opt.smartindent = true

-- Wrap Lines
vim.opt.wrap = true

-- Dont allow vim to take any backups
vim.opt.swapfile = false -- Avoid Vim Swap Warnings
vim.opt.backup = false -- Avoid Backup File Creation

-- Enables Persistent Undo (Doesn't delete undo branch on exiting vim session)
vim.opt.undofile = true

-- Making sure a dedicated directory exists to save undoes to the disk.
local undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.fn.mkdir(undodir, "p")
vim.opt.undodir = undodir

-- Better Searching using / and ?
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.smartcase = true

-- Colorful terminal
vim.opt.termguicolors = true

-- Not sure (Yet to figure out)
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
