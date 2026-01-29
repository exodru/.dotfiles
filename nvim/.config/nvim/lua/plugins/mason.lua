return {
	-- mason UI
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	-- bridge between mason UI and LSP (handles "ensure_installed")
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			-- keep this list in sync with the 'servers' list in your lspconfig.lua
			ensure_installed = {
				"lua_ls",
				"clangd",
				"basedpyright",
				"gopls",
				"texlab",
			},
		},
	},
}
