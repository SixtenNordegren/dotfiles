-- Setting the leader
vim.g.mapleader = ","
vim.g.maplocalleader = " "

-- nvim generall settings
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 999
vim.opt.hlsearch = false
vim.opt.textwidth = 75
vim.opt.wrap = false
vim.opt.spell = true
vim.opt.tabstop = 3
vim.g.auto_open_quickfix = 0
vim.cmd("colorscheme nightfly") -- TTY friendly colorscheme
-- Basetheme is alredy TTY friendly, do we really need this?

vim.opt.conceallevel = 2

-- Settings specific for slime
vim.g.slime_target = "tmux"
vim.g.slime_default_config = {
	socket_name = "default",
	target_pane = "{right-of}",
	default_send_input = "top",
	default_send_input_stay = "top",
}

vim.cmd("Copilot disable")
-- vim.g.zig_fmt_autosave = 0
