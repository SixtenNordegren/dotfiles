return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"j-hui/fidget.nvim",
		"folke/neodev.nvim",
	},
	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local servers = {
			jdtls = {},
			bashls = {},
			jedi_language_server = {},
			-- bashls = {
			-- 	settings = { name = "bash-language-server", cmd = { "bash-language-server", "start" } },
			-- },
			marksman = {},
			tailwindcss = {
				filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
			},

			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						completion = { callSnippet = "Replace" },
					},
				},
			},
			ltex = {
				settings = {
					ltex = {
						language = "en-GB",
						enabledRules = {
							["en-GB"] = { "PASSIVE_VOICE" },
						},
						disabledRules = { ["en-GB"] = { "ARROWS" } },
						dictionary = { ["en-GB"] = Dictionary_ltex },
					},
				},
			},
			texlab = {},
		}

		require("mason").setup()

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
			"autopep8",
			"latexindent",
			"shfmt",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
