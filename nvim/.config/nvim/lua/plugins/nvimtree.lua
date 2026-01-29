local gwidth = vim.api.nvim_list_uis()[1].width
local gheight = vim.api.nvim_list_uis()[1].height
local width = 70
local height = 35

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				adaptive_size = false,
				centralize_selection = false,
				width = 50,
				side = "left",
				preserve_window_proportions = false,
				number = true,
				relativenumber = false,
				signcolumn = "yes",
				float = {
					enable = false,
					quit_on_focus_loss = true,
					open_win_config = {
						relative = "editor",
						border = "rounded",
						width = width,
						height = height,
						row = (gheight - height) * 0.5,
						col = (gwidth - width) * 0.5,
					},
				},
			},
			renderer = {
				group_empty = true,
				highlight_git = true,
				indent_width = 2,
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						bottom = "─",
						none = " ",
					},
				},
			},
			filters = {
				dotfiles = true,
			},
			hijack_directories = {
				enable = true,
				auto_open = true,
			},
			diagnostics = {
				enable = true,
				show_on_dirs = false,
				show_on_open_dirs = true,
				debounce_delay = 500,
				severity = {
					min = vim.diagnostic.severity.HINT,
					max = vim.diagnostic.severity.ERROR,
				},
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			actions = {
				open_file = {
					quit_on_open = true,
					eject = true,
					resize_window = true,
					relative_path = true,
					window_picker = {
						enable = true,
						picker = "default",
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "nofile", "terminal", "help" },
						},
					},
				},
			},
		})
	end,
}
