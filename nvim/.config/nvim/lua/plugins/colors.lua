return {
	"dgox16/oldworld.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("oldworld").setup({
			terminal_colors = true,
			variant = "default", --- default, oled, cooler
		})

		vim.cmd("colorscheme oldworld")

		-- Telescope window borders
		vim.cmd("hi TelescopeBorder guibg=none ctermbg=none guifg=#7B7EEE")
		vim.cmd("hi TelescopePromptBorder guibg=none ctermbg=none guifg=#7B7EEE")
		vim.cmd("hi TelescopeResultsBorder guibg=none ctermbg=none guifg=#7B7EEE")
		vim.cmd("hi TelescopePreviewBorder guibg=none ctermbg=none guifg=#7B7EEE")

		-- Telescope backgrounds (set to none for transparency)
		vim.cmd("hi TelescopeTitle guibg=none")
		vim.cmd("hi TelescopeNormal guibg=none ctermbg=none")
		vim.cmd("hi TelescopePromptNormal guibg=none ctermbg=none")
		vim.cmd("hi TelescopeResultsNormal guibg=none ctermbg=none")
		vim.cmd("hi TelescopePreviewNormal guibg=none ctermbg=none")

		-- Other default neovim highlights
		vim.cmd("hi Normal guibg=none ctermbg=none")
		vim.cmd("hi NormalNC guibg=none ctermbg=none")
		vim.cmd("hi NormalFloat guibg=none ctermbg=none")
		vim.cmd("hi FloatBorder guibg=none ctermbg=none guifg=#7B7EEE")
		vim.cmd("hi LineNr guibg=none ctermbg=none")
		vim.cmd("hi Folded guibg=none ctermbg=none")
		vim.cmd("hi NonText guibg=none ctermbg=none")
		vim.cmd("hi SpecialKey guibg=none ctermbg=none")
		vim.cmd("hi VertSplit guibg=none ctermbg=none")
		vim.cmd("hi CursorLineNr guibg=none ctermbg=none")
		vim.cmd("hi StatusLine guibg=none ctermbg=none")
		vim.cmd("hi EndOfBuffer guibg=none ctermbg=none")
		vim.cmd("hi SignColumn guibg=none ctermbg=none")
	end,
}
