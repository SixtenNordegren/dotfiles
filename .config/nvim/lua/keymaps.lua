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

-- Buffer navigation
vim.keymap.set("n", "[b", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "]b", ":bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bc", "bdelete<CR>", { desc = "Clear current buffer"})
vim.keymap.set("n", "<leader>bd", "%bwipeout<CR>", {desc = "Clear all buffers except current"})

-- Tab navigation
vim.keymap.set("n", "[t", ":tabn<CR>", { desc = "Next tab" })
vim.keymap.set("n", "]t", ":tabp<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })

-- Disable Arrow keys. 
vim.keymap.set("n", "<left>", "<Nop>")
vim.keymap.set("n", "<right>", "<Nop>")
vim.keymap.set("n", "<up>", "<Nop>")
vim.keymap.set("n", "<down>", "<Nop>")

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
