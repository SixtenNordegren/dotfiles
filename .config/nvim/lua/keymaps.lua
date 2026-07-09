-- Diagnostics
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, on_jump = function() vim.diagnostic.open_float() end })
end, { desc = "Prev diagnostic + float" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, on_jump = function() vim.diagnostic.open_float() end })
end, { desc = "Next diagnostic + float" })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Window navigation
vim.keymap.set("n", "]w", "<C-w>l", { desc = "Move to the *right* window." })
vim.keymap.set("n", "[w", "<C-w>h", { desc = "Move to the *left* window." })

-- Tab navigation
vim.keymap.set("n", "[b", ":tabn<CR>", { desc = "Next tab" })
vim.keymap.set("n", "]b", ":tabp<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })

-- Git
vim.api.nvim_create_user_command("GitBlameLine", function()
	local line_number = vim.fn.line(".")
	local filename = vim.api.nvim_buf_get_name(0)
	print(vim.system({ "git", "blame", "-L", line_number .. ",+1", filename }):wait().stdout)
end, { desc = "Print the git blame for the current line." })

-- File utilities
vim.keymap.set("n", "<leader>fy", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("Yanked: " .. path)
end, { desc = "Yank absolute file path to + register" })

vim.keymap.set("n", "<leader>gy", function()
	local fname = vim.fn.expand("%:p")
	local root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
	if root and vim.v.shell_error == 0 then
		local rel = fname:sub(#root + 2)
		vim.fn.setreg("+", rel)
		print("Yanked: " .. rel)
	else
		print("Not in a git repo")
	end
end, { desc = "Yank file path relative to git root" })

vim.keymap.set("n", "<leader>pv", ":Ex<CR>", { desc = "Open netrw file explorer" })

-- Telescope
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "Live grep" })

-- Conform (formatting)
vim.keymap.set({ "n", "v" }, "<leader>lf", function()
	require("conform").format({ async = true })
end, { desc = "Format buffer" })

-- Undotree
vim.keymap.set("n", "<leader>u", ":Undotree<CR>", { desc = "Open undotree" })
