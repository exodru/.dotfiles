local luasnip = require("luasnip")

luasnip.config.set_config({
	history = true, -- lets u jump back into snippets even if you typed outside them
	updateevents = "TextChanged,TextChangedI", -- dynamic update as you type inside nodes
})

require("luasnip.loaders.from_lua").lazy_load({
	paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
})
