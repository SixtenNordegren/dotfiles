-- Aggregator: installs/updates plugins and triggers each plugin module's
-- top-level setup. Each lua/plugins/<name>.lua file is responsible for
-- setting up exactly one plugin (or one tightly-coupled plugin group).

vim.pack.add({
	"https://github.com/folke/which-key.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/stevearc/quicker.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
})

require("plugins.which-key")
require("plugins.telescope")
require("plugins.lsp")
require("plugins.conform")
require("plugins.cmp")
require("plugins.gitsigns")
require("plugins.quicker")
require("plugins.undotree")
