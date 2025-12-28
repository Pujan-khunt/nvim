-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- Enable auto write (kinda like autosave)
opt.autowrite = true 

opt.autoindent = true

-- opt.clipboard = "unnamedplus"

-- Hide * markup for bold and italic, but not markers with substitutions
opt.conceallevel = 2 

-- Confirm to save changes before exiting modified buffer
opt.confirm = true 

-- Enable highlighting of the current line
opt.cursorline = true 

-- Use spaces instead of tabs
opt.expandtab = true 

-- Ignore case
opt.ignorecase = true 

-- preview incremental substitute
opt.inccommand = "nosplit" 

-- Maintain a stack when navigating inside another window
opt.jumpoptions = "stack,view"

-- Wrap lines at convenient points, only works if wrap = true
opt.linebreak = true 

-- Show some invisible characters
opt.list = true 
opt.listchars = "tab:» ,trail:·,nbsp:␣"

-- Print line number
opt.number = true 

-- Relative line numbers
opt.relativenumber = true 

-- Always show the signcolumn, otherwise it would shift the text each time
opt.signcolumn = "yes"

-- Do't ignore case with capitals
opt.smartcase = true 

-- Insert indents automatically
opt.smartindent = true 

-- Put new windows below current
opt.splitbelow = true 

opt.splitkeep = "screen"

-- Put new windows right of current
opt.splitright = true 

-- Number of spaces tabs count for
opt.tabstop = 2 
opt.softtabstop = 2 
opt.shiftwidth = 2

-- True color support
opt.termguicolors = true

-- Disable swapfiles and all the headaches that it causes
opt.swapfile = false

-- Avoid getting slammed with infinite folds at start
opt.foldlevel = 99
opt.foldlevelstart = 99
