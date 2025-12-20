return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	opts = { --
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		keymap = { preset = "default", ["<C-e>"] = { "select_and_accept", "fallback" }, ["<C-y>"] = { "hide" } },

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		completion = {
			menu = {
				border = "rounded",
				winhighlight = "Normal:None,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
			},
			documentation = {
				auto_show = true, -- You might want this on now!
				window = {
					border = "rounded",
					winhighlight = "Normal:None,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				},
			},
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
