return {
	"nvim-pack/nvim-spectre",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"kyazdani42/nvim-web-devicons",
	},
	config = function()
		require("spectre").setup({
			default = {
				replace = {
					cmd = "sed",
				},
			},
			is_block_ui_break = true,
		})

		vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
			desc = "Toggle Spectre Search Panel",
		})
		vim.keymap.set(
			"n",
			"<leader>sw",
			'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
			{ desc = "Search Current Word" }
		)
		vim.keymap.set(
			"v",
			"<leader>sw",
			'<esc><cmd>lua require("spectre").open_visual()<CR>',
			{ desc = "Search Current Selection" }
		)
		vim.keymap.set(
			"n",
			"<leader>sp",
			'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
			{ desc = "Search in Current File" }
		)
	end,
}
