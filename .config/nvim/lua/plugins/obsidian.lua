return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	event = {
		"BufReadPre path/to/my-vault/**.md",
		"BufNewFile path/to/my-vault/**.md",
	},
	dependencies = {
		-- Required.
		"hrsh7th/nvim-cmp",
		"nvim-lua/plenary.nvim",
	},
	opts = {
		-- We need to make this system independent. Fixing the path
		-- each time is not a good idea.
		workspaces = {
			-- {
			-- 	name = "Personal notes",
			-- 	path = "/home/sixten/Documents/Obsidian Vault/",
			-- },
			{
				name = "CFT project",
				path = "~/projects/CFT_notes/",
			},
		},

		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		-- disable_frontmatter = true,
	},
}
