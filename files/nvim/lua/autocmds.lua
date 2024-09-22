local group = vim.api.nvim_create_augroup("Filetypesettings", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.md",
	callback = function()
		vim.bo.textwidth = 0
		vim.o.wrap = true
	end,
	group = group,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.sage",
	callback = function()
		vim.o.filetype = "python"
		vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
	end,
	group = group,
})
