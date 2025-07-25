return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_view_zathura = {
			options = { "--reparent", "--synctex-forward", "%l:1:%f" },
		}
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_syntax_enabled = 1

		-- Enable sync on VimtexView
		vim.api.nvim_create_autocmd("User", {
			pattern = "VimtexEventView",
			callback = function()
				local winid = vim.fn.trim(vim.fn.system("xdotool getactivewindow"))
				vim.fn.system("sleep 0.01 && xdotool windowactivate " .. winid)
				vim.fn.system("sleep 0.01 && xdotool windowraise " .. winid)
			end,
		})
	end,
}
