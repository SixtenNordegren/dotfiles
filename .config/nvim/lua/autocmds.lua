local group = vim.api.nvim_create_augroup("Filetypesettings", { clear = true })

-- sage
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.sage",
	callback = function()
		vim.o.filetype = "python"
		vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
	end,
	group = group,
})

-- vimtex
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.tex",
	callback = function()
		vim.cmd("VimtexView")
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventQuit",
	command = "VimtexClean",
})

-- markdown
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.md",
	callback = function()
		vim.bo.textwidth = 0
		vim.o.wrap = true
	end,
	group = group,
})

-- -- csv
vim.api.nvim_create_autocmd("FileType", {
	pattern = "csv",
	callback = function()
		vim.cmd("TSBufDisable highlight")
	end,
})

-- Java webdev
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.java", "*.properties", "*.html" },
	callback = function()
		-- Trigger Gradle build
		vim.fn.jobstart("./gradlew --no-rebuild build")
	end,
})

-- HTML
vim.api.nvim_create_autocmd("FileType", {
	pattern = "html",
	callback = function()
		vim.opt.omnifunc = "htmlcomplete#CompleteTags"
	end,
})
