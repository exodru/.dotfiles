local mode_map = {
	["n"] = "NORMAL",
	["no"] = "O·P",
	["nov"] = "O·P",
	["noV"] = "O·P",
	["no\22"] = "O·P",
	["niI"] = "N·I",
	["niR"] = "N·R",
	["niV"] = "N",
	["nt"] = "N·T",
	["v"] = "VIS",
	["vs"] = "V",
	["V"] = "VIS·L",
	["Vs"] = "VIS·L",
	["\22"] = "VIS·B",
	["\22s"] = "VIS·B",
	["s"] = "S",
	["S"] = "S·L",
	["\19"] = "S·B",
	["i"] = "INSERT",
	["ic"] = "I·C",
	["ix"] = "I·X",
	["R"] = "R",
	["Rc"] = "R·C",
	["Rx"] = "R·X",
	["Rv"] = "V·R",
	["Rvc"] = "RVC",
	["Rvx"] = "RVX",
	["c"] = "C",
	["cv"] = "EX",
	["ce"] = "EX",
	["r"] = "R",
	["rm"] = "M",
	["r?"] = "C",
	["!"] = "SH",
	["t"] = "T",
}

local function modes()
	return mode_map[vim.api.nvim_get_mode().mode] or "__"
end

local colors = {
	bg = "#191D24",
	fg = "#D8DEE9",
	yellow = "#EBCB8B",
	red = "#BF616A",
	green = "#A3BE8C",
	blue = "#81A1C1",
	gray = "#4C566A",
	purple = "#B48EAD",
	orange = "#D08770",
}

local custom_theme = {
	normal = {
		a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
		b = { fg = colors.fg, bg = "NONE" },
		c = { fg = colors.gray, bg = "NONE" },
	},
	insert = {
		a = { fg = colors.bg, bg = colors.green, gui = "bold" },
		b = { fg = colors.fg, bg = "NONE" },
		c = { fg = colors.gray, bg = "NONE" },
	},
	visual = {
		a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
		b = { fg = colors.fg, bg = "NONE" },
		c = { fg = colors.gray, bg = "NONE" },
	},
	replace = {
		a = { fg = colors.bg, bg = colors.red, gui = "bold" },
		b = { fg = colors.fg, bg = "NONE" },
		c = { fg = colors.gray, bg = "NONE" },
	},
	command = {
		a = { fg = colors.bg, bg = colors.orange, gui = "bold" },
		b = { fg = colors.fg, bg = "NONE" },
		c = { fg = colors.gray, bg = "NONE" },
	},
	inactive = {
		a = { fg = colors.gray, bg = "NONE" },
		b = { fg = colors.gray, bg = "NONE" },
		c = { fg = colors.gray, bg = "NONE" },
	},
}

local conditions = {
	not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("lualine").setup({
			options = {
				theme = custom_theme,
				component_separators = "|",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					-- { modes, color = { gui = "bold" }, separator = { right = "" }, right_padding = 2 },
					{ modes, color = { gui = "bold" }, separator = { right = "" }, right_padding = 2 },
				},
				lualine_b = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " " },
						diagnostics_color = {
							color_error = { fg = colors.red },
							color_warn = { fg = colors.yellow },
							color_info = { fg = colors.blue },
						},
					},
					{
						"filename",
						path = 1,
						file_status = true,
						color = { fg = colors.white, gui = "bold" },
						-- separator = { right = "" },
						separator = { right = "" },
						cond = conditions.not_empty,
					},
					{
						"branch",
						color = { fg = colors.flamingo, gui = "bold" },
						-- separator = { right = "" },
						separator = { right = "" },
					},
					{
						"diff",
						symbols = { added = " ", modified = "󰝤 ", removed = " " },
						-- separator = { right = "", left = "" },
						separator = { right = "", left = "" },
						diff_color = {
							added = { fg = colors.green },
							modified = { fg = colors.yellow },
							removed = { fg = colors.red },
						},
					},
				},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {
					{
						"filesize",
						color = { gui = "bold", fg = colors.white },
						cond = conditions.not_empty,
					},
					{
						"filetype",
						color = { gui = "bold", fg = colors.teal },
					},
					{
						"fileformat",
						symbols = {
							unix = "UNIX", -- e712
							dos = "", -- e70f
							mac = "", -- e711
						},
						color = { gui = "bold", fg = colors.cherry },
					},
					{ "progress", color = { gui = "bold", fg = colors.teal } },
				},
				lualine_z = {
					{
						"location",
						separator = { left = "" },
						-- separator = { left = "" },
						left_padding = 2,
						color = { gui = "bold", bg = colors.teal },
					},
				},
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {},
		})
	end,
}
