-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- setup lazy.nvim
require("lazy").setup({
	-- load plugins dir
	spec = {
		{ import = "plugins" },
	},

	-- automatically check for plugin updates
	checker = { enabled = true },

	-- profiling (adds overhead, enable when debugging)
	profiling = {
		-- enables extra stats on the debug tab related to the loader cache (additionally gathers stats about all package.loaders)
		loader = false,
		-- track each new require in the Lazy profiling tab
		require = false,
	},
})
