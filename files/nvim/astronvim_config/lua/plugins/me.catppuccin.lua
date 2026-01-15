return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	opts = {
		--transparent_background = true,
		integrations = {
			which_key = true,
			notify = true,
			noice = true,
		},
		flavour = "auto", -- auto, latte, frappe, macchiato, mocha
		background = {
			light = "latte",
			dark = "mocha",
		},
	},
}
