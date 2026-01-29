return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	config = function()
		local ls = require("luasnip")

		-- tex buffers can see latex snippets
		ls.filetype_extend("tex", { "latex" })
		ls.filetype_extend("plaintex", { "latex" })

		require("snippets.tex")
	end,
}
