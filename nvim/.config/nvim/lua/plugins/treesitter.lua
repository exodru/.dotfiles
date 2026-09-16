-- check if treesitter already exists
local has_ts, treesitter = pcall(require, "nvim-treesitter")

if has_ts then
	treesitter.setup({})

	-- call the new async installer array directly (rewrite of treesitter)
	treesitter.install({
		"vim",
		"vimdoc",
		"rust",
		"c",
		"cpp",
		"sql",
		"go",
		"yaml",
		"toml",
		"html",
		"css",
		"javascript",
		"json",
		"lua",
		"markdown",
		"python",
		"typescript",
		"vue",
		"svelte",
		"bash",
		"dockerfile",
	})
end

-- turn on native nvim treesitter highlighting for ALL filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		-- start treesitter only if nvim has a valid parser compiled for this language
		local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
		if lang and vim.treesitter.query.get(lang, "highlights") then
			vim.treesitter.start()
		end
	end,
})

return {
	src = "https://github.com/nvim-treesitter/nvim-treesitter",
	branch = "main",
}
