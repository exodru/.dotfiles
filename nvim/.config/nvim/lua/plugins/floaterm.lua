return {
	"voldikss/vim-floaterm",
	config = function()
		vim.g.floaterm_width = 0.8
		vim.g.floaterm_height = 0.8
		vim.g.floaterm_wintype = "float"
		vim.g.floaterm_title = "Terminal ($1/$2)"
		vim.g.floaterm_titleposition = "topleft"
	end,
}
