local opts = { noremap = true, silent = true }

-- Preferential adjusments of default keybinds:
vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically
vim.keymap.set("n", "+", [[<cmd>horizontal resize +3<cr>]]) -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "_", [[<cmd>horizontal resize -3<cr>]]) -- make the window smaller horizontally by pressing shift and -
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
vim.keymap.set({ 'n', "i" }, '<leader>bd', '<Esc>:bd<CR>', opts)
vim.keymap.set({ "n", "i", "v" }, '<C-s>', '<Esc>:w<CR>', opts)
vim.keymap.set({ "n", "i", "v" }, '<leader>fq', '<Esc>:q!<CR>', opts)
vim.keymap.set("n", '<C-d>', '<C-d>zz', opts)
vim.keymap.set("n", '<C-d>', '<C-d>zz', opts)
vim.keymap.set("n", 'n', 'nzz', opts)
vim.keymap.set("n", 'N', 'Nzz', opts)
vim.keymap.set("n", 'gg', 'ggzz', opts)
vim.keymap.set("n", 'G', 'Gzz', opts)
vim.keymap.set("n", '*', '*zz', opts)
vim.keymap.set("n", '#', '#zz', opts)
vim.keymap.set("n", '%', '%zz', opts)
vim.keymap.set("n", '<leader>cs', '<C-w>c', opts) -- close split window

-- Buffers
vim.keymap.set("n", '<S-h>', ':bprev<CR>', opts)
vim.keymap.set("n", '<S-l>', ':bnext<CR>', opts)

-- Telescope keybinds:
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<C-f>o', telescope.find_files, {})
vim.keymap.set('n', '<leader>sg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>vr', telescope.registers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})
vim.keymap.set('n', '<leader>fs', telescope.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>gs', telescope.git_stash, {})
vim.keymap.set('n', '<leader>gb', telescope.git_branches, {})
vim.keymap.set('n', '<leader>gc', telescope.git_commits, {})
vim.keymap.set('n', '<leader>bc', telescope.git_bcommits, {})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>dx', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', ':lua vim.diagnostic.goto_prev()<CR>zz', {})
vim.keymap.set('n', ']d', ':lua vim.diagnostic.goto_next()<CR>zz', {})
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    --	requires vim.opt.splitright = true
    vim.keymap.set('n', 'gd', ':vsp<cr> :lua vim.lsp.buf.definition()<CR> zz', opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>*', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- brackets
vim.keymap.set("i", "\"<tab>", "\"\"<Left>", opts)
vim.keymap.set("i", "'<tab>", "''<Left>", opts)
vim.keymap.set("i", "(<tab>", "()<Left>", opts)
vim.keymap.set("i", "{<tab>", "{}<Left>", opts)
vim.keymap.set("i", "[<tab>", "[]<Left>", opts)
vim.keymap.set("i", "{<CR>", "{<CR>}<Esc>O", opts)
vim.keymap.set("i", "(<CR>", "(<CR>)<Esc>O", opts)

--floaterm
vim.keymap.set("n", "<C-g>i", ":FloatermNew --height=0.9 --width=0.9 --wintype=float lazygit<CR>", opts)
vim.keymap.set("n", "<C-g>t", ":FloatermNew --height=0.9 --width=0.9 --wintype=float <CR>", opts)
vim.keymap.set("n", "<C-g>n", ":FloatermNext<CR>", opts)
vim.keymap.set("n", "<C-g>p", ":FloatermPrev<CR>", opts)
vim.keymap.set("n", "<C-g>o", ":FloatermShow<CR>", opts)
vim.keymap.set("t", "<C-g>o", "<C-\\><C-n>:FloatermToggle<CR>", opts)

-- nvim-dap
vim.keymap.set("n", "<leader>dct", '<cmd>lua require"dap".continue()<CR>', opts)
vim.keymap.set("n", "<leader>dst", '<cmd>lua require"dap".terminate()<CR>', opts)
vim.keymap.set("n", "<leader>dsv", '<cmd>lua require"dap".step_over()<CR>', opts)
vim.keymap.set("n", "<leader>dsi", '<cmd>lua require"dap".step_into()<CR>', opts)
vim.keymap.set("n", "<leader>dso", '<cmd>lua require"dap".step_out()<CR>', opts)
vim.keymap.set("n", "<leader>dtb", '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
