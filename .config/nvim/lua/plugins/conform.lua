return {
	-- This is the formatter. In case you forget. Again..
	"stevearc/conform.nvim",
	lazy = false,
	keys = {
		{
			"<leader>af",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "n",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = true,
		format_on_save = function(bufnr)
			local disable_filetypes = { cpp = true }
			return {
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "autopep8" },
			latex = { "latexindent" },
			shell = { "shfmt" },
			bash = { "shfmt" },
			html = { "htmlbeautifier" },
			css = { "prettierd" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			vue = { "prettierd" },
			json = { "prettierd" },
			java = { "google-java-format" },
			groovy = { "npm-groovy-lint" },
			c = { "clang-format" },
		},
	},
}
