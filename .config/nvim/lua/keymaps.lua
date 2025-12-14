-- Movement between diagnostic messages
vim.keymap.set("n", "<leader>lk", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "<leader>lj", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>lf", function()
	require("conform").format()
end, { desc = "Format file" })

-- Movement between buffers
vim.keymap.set("n", "<leader>bb", "<cmd>:bp<CR>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>:bn<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>:bdel<CR>", { desc = "Delete current buffer" })

-- netrw
vim.keymap.set("n", "<leader>pv", "<cmd>:Ex<CR>", { desc = "Open file tree" })

-- Telescope
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Search files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Search buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search helptags" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[r]e[n]ame" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[c]ode [a]ction" })

-- Language Server Protocol (lsp)
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[g]oto [D]eclaration" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[g]oto [d]efinition" })

-- Slime
vim.keymap.set("n", "<c-c><c-c>", "<cmd>:SlimeSend<CR>", { noremap = true, desc = "SlimeSend" })
