do
	-- General Settings
	vim.loader.enable()
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "
	vim.g.have_nerd_font = false
	vim.g.relativenumber = true
	vim.opt.completeopt = { "menuone", "noinsert" }

	-- Plugins
	vim.pack.add({
		"https://github.com/folke/which-key.nvim",
		"https://github.com/nvim-lua/plenary.nvim",
		"https://github.com/nvim-telescope/telescope.nvim",
		"https://github.com/neovim/nvim-lspconfig",
		"https://github.com/mason-org/mason.nvim",
		"https://github.com/mason-org/mason-lspconfig.nvim",
		"https://github.com/stevearc/conform.nvim",
		"https://github.com/hrsh7th/nvim-cmp",
		"https://github.com/L3MON4D3/LuaSnip",
		"https://github.com/hrsh7th/cmp-nvim-lsp",
		"https://github.com/hrsh7th/cmp-path",
		"https://github.com/hrsh7th/cmp-buffer",
		"https://github.com/stevearc/quicker.nvim",
		"https://github.com/lewis6991/gitsigns.nvim",
	})
	vim.cmd("packadd nvim.difftool")
	vim.cmd("packadd nvim.undotree")

	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local cmp_lsp = require("cmp_nvim_lsp")

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "buffer" },
		},
	})
	require("quicker").setup({})
	require("gitsigns").setup({})
	require("telescope").setup({})
	require("mason").setup({})
	local capabilities = cmp_lsp.default_capabilities()

	require("mason-lspconfig").setup({
		handlers = {
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
				})
			end,
		},
	})

	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			ts = { "ts-standard" },
			vue = { "oxfmt" },
		},
	})
	require("quicker").setup({})
	require("gitsigns").setup({})

	-- Keymaps
	vim.keymap.set("n", "<leader>fp", function()
		local path = vim.fn.expand("%:p")
		vim.fn.setreg("+", path)
		print("Yanked: " .. path)
	end, { desc = "Yank absolute file path to + register" })

	vim.keymap.set("n", "<leader>gp", function()
		local fname = vim.fn.expand("%:p")
		local root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
		if root and vim.v.shell_error == 0 then
			local rel = fname:sub(#root + 2) -- strip root + '/'
			vim.fn.setreg("+", rel)
			print("Yanked: " .. rel)
		else
			print("Not in a git repo")
		end
	end, { desc = "Yank file path relative to git root" })
	vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
	vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep)
	vim.keymap.set({ "n", "v" }, "<leader>lf", function()
		require("conform").format({ async = true })
	end)
	vim.keymap.set("n", "<leader>pv", ":Ex<CR>")
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_prev({ float = true })
	end, { desc = "Prev diagnostic + float" })
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_next({ float = true })
	end, { desc = "Next diagnostic + float" })

	vim.api.nvim_create_autocmd("TextYankPost", {
		desc = "Highlightwhenyanking(copying)text",
		callback = function()
			vim.hl.on_yank()
		end,
	})
	vim.keymap.set("n", "]w", "<C-w>l", { desc = "Move to the *right* window." })
	vim.keymap.set("n", "[w", "<C-w>h", { desc = "Move to the *left* window." })

	vim.api.nvim_create_user_command("GitBlameLine", function()
		local line_number = vim.fn.line(".")
		local filename = vim.api.nvim_buf_get_name(0)
		print(vim.system({ "git", "blame", "-L", line_number .. ",+1", filename }):wait().stdout)
	end, { desc = "Print the git blame for the current line." })

	vim.keymap.set("n", "<leader>u", ":Undotree<CR>")

	vim.keymap.set("n", "[b", ":tabn<CR>")
	vim.keymap.set("n", "]b", ":tabp<CR>")
	vim.keymap.set("n", "<leader>tn", ":tabnew<CR>")

end
