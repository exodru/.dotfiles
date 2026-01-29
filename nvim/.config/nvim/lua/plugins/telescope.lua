return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.0",
		dependencies = { "nvim-lua/plenary.nvim" },

		require("telescope").setup({
			defaults = {
				-- hide the .git folder even when 'hidden = true' is set
				file_ignore_patterns = { "%.git/" },
				window = { border = true },
			},
			pickers = {
				find_files = {
					theme = "ivy",
					hidden = false,
				},
				live_grep = {
					theme = "ivy",
				},
			},
		}),
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
