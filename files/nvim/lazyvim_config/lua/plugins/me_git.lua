return {
	{ "lewis6991/gitsigns.nvim" },
	{
		"sindrets/diffview.nvim",
		keys = {
			{ "<leader>gvd", "<cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
			{ "<leader>gvc", "<cmd>DiffviewClose<CR>", desc = "Close Diffview" },
			{ "<leader>gvh", "<cmd>DiffviewFileHistory %<CR>", desc = "File git history" },
		},
	},
}
