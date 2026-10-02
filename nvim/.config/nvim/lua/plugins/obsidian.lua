vim.pack.add({
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	{
		src = "https://github.com/obsidian-nvim/obsidian.nvim",
		version = vim.version.range("*"), -- use latest release, remove to use latest commit
	},
})

require("obsidian").setup({
	legacy_commands = false, -- this will be removed in 4.0.0
	workspaces = {
		{
			name = "md-notes",
			path = "~/md-notes",
		},
		-- {
		-- 	name = "work",
		-- 	path = "~/vaults/work",
		-- },
	},
	attachments = {
		folder = "EXTERNAL_ATTACHMENTS",

		img_text_func = function(path)
			local name = vim.fs.basename(tostring(path))
			local encoded_name = require("obsidian.util").urlencode(name)
			return string.format("![%s](%s)", name, encoded_name)
		end,
	},
	image = {
		resolve = function(path, src)
			local api = require("obsidian.api")
			if api.path_is_note(path) then
				return api.resolve_attachment_path(src)
			end
		end,
	},
})

vim.keymap.set("n", "<leader>p", "<cmd>Obsidian paste_img<cr>", { desc = "Paste clipboard image natively" })
