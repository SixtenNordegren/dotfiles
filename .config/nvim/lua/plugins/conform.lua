require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		typescript = { "biome" },
		javascript = { "biome" },
		vue = { "biome" },
	},
})
