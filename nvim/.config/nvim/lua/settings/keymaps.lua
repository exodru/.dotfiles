local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local builtin = require("telescope.builtin")

-- ++++++++ PERSONAL ADJUSTMENTS OF DEFAULT KEYBINDS +++++++++
vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically
vim.keymap.set("n", "+", [[<cmd>horizontal resize +3<cr>]]) -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "_", [[<cmd>horizontal resize -3<cr>]]) -- make the window smaller horizontally by pressing shift and -
vim.keymap.set({ "n", "i" }, "<leader>bd", "<Esc>:bd<CR>", opts)
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<Esc>:w<CR>", opts)
vim.keymap.set({ "n", "i", "v" }, "<leader>fq", "<Esc>:q!<CR>", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)
vim.keymap.set("n", "gg", "ggzz", opts)
vim.keymap.set("n", "G", "Gzz", opts)
vim.keymap.set("n", "*", "*zz", opts)
vim.keymap.set("n", "#", "#zz", opts)
vim.keymap.set("n", "%", "%zz", opts)
vim.keymap.set("n", "<leader>cs", "<C-w>c", opts) -- close split window

-- ++++++++ BUFFERS ++++++++
vim.keymap.set("n", "<S-h>", ":bprev<CR>", opts)
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)

-- ++++++++ BRACKETS ++++++++
vim.keymap.set("i", '"<tab>', '""<Left>', opts)
vim.keymap.set("i", "'<tab>", "''<Left>", opts)
vim.keymap.set("i", "(<tab>", "()<Left>", opts)
vim.keymap.set("i", "{<tab>", "{}<Left>", opts)
vim.keymap.set("i", "[<tab>", "[]<Left>", opts)
vim.keymap.set("i", "{<CR>", "{<CR>}<Esc>O", opts)
vim.keymap.set("i", "(<CR>", "(<CR>)<Esc>O", opts)

-- +++++++ GLOBAL MAPPINGS +++++++
-- check `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", ":lua vim.diagnostic.goto_prev()<CR>zz", {})
vim.keymap.set("n", "]d", ":lua vim.diagnostic.goto_next()<CR>zz", {})
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- ++++++++ FILEPICKER ++++++++
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- ++++++++ FLOATERM ++++++++
vim.keymap.set("n", "<C-g>i", ":FloatermNew --height=0.9 --width=0.9 --wintype=float lazygit<CR>", opts)
vim.keymap.set("n", "<C-g>t", ":FloatermNew --height=0.9 --width=0.9 --wintype=float <CR>", opts)
vim.keymap.set("n", "<C-g>n", ":FloatermNext<CR>", opts)
vim.keymap.set("n", "<C-g>p", ":FloatermPrev<CR>", opts)
vim.keymap.set("n", "<C-g>o", ":FloatermShow<CR>", opts)
vim.keymap.set("t", "<C-g>o", "<C-\\><C-n>:FloatermToggle<CR>", opts)

-- +++++++ TELESCOPE +++++++++
keymap("n", "<C-f>o", function()
	builtin.find_files({ hidden = true })
end, { desc = "Telescope find files" })

keymap("n", "<C-f>f", function()
	builtin.git_files()
end, { desc = "Telescope search through git files, respects .gitignore" })

keymap("n", "<C-f>p", function()
	builtin.buffers()
end, { desc = "Telescope buffers" })

keymap("n", "<leader>fg", function()
	builtin.live_grep()
end, { desc = "Telescope live grep" })

keymap("n", "<leader>fh", function()
	builtin.help_tags()
end, { desc = "Telescope help tags" })

keymap("n", "<leader>fs", function()
	builtin.lsp_document_symbols()
end, { desc = "Telescope document symbols" })

keymap("n", "<leader>vr", function()
	builtin.lsp_references()
end, { desc = "Telescope references for word under cursor" })

keymap("n", "<leader>vd", function()
	builtin.diagnostics()
end, { desc = "Telescope lists open buffers diagnostics" })

keymap("n", "<leader>gd", function()
	builtin.lsp_definitions()
end, { desc = "Telescope go to the definition of word under cursor" })

keymap("n", "<leader>gt", function()
	builtin.lsp_type_definitions()
end, { desc = "Telescope go to the TYPE definition of word under cursor" })

-- manpages
keymap("n", "<leader>mp", function()
	builtin.man_pages()
end, { desc = "Telescope man pages" })

-- histories
keymap("n", "<leader>sh", function()
	builtin.search_history()
end, { desc = "Telescope list previous searches" })

keymap("n", "<leader>ch", function()
	builtin.command_history()
end, { desc = "Telescope list previous commands" })

-- git telescope
keymap("n", "<leader>gs", function()
	builtin.git_stash()
end, { desc = "Telescope git stash" })

keymap("n", "<leader>gt", function()
	builtin.git_status()
end, { desc = "Telescope git status" })

keymap("n", "<leader>gb", function()
	builtin.git_branches()
end, { desc = "Telescope git branches" })

keymap("n", "<leader>gc", function()
	builtin.git_commits()
end, { desc = "Telescope git commits" })

keymap("n", "<leader>bc", function()
	builtin.git_bcommits()
end, { desc = "Telescope git commit PER BUFFER WITH DIFF PREVIEW" })
