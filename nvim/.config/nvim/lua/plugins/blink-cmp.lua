return {
	"saghen/blink.cmp",
	cond = not vim.g.vscode,
	lazy = false,
	dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
	opts = {
		snippets = { preset = "luasnip" },
		keymap = {
			preset = "default",
			["<C-e>"] = { "select_and_accept", "fallback" },
			["<C-y>"] = { "hide" },
			["<C-l>"] = { "snippet_forward", "fallback" },
			["<C-h>"] = { "snippet_backward", "fallback" },
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		completion = {
			keyword = { range = "full" },
			list = { selection = { preselect = true, auto_insert = false } },
			ghost_text = { enabled = true },
			-- Show documentation when selecting a completion item
			documentation = { auto_show = true, auto_show_delay_ms = 250 },
			menu = {
				auto_show = true,
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind" },
					},
				},
			},
		},
		signature = { enabled = true },
	},
}
