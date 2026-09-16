local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
-- local builtin = require("telescope.builtin")

-- ++++++++ PERSONAL ADJUSTMENTS OF DEFAULT KEYBINDS +++++++++
vim.keymap.set("n", "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)"})

vim.keymap.set("n", "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)"})

vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear highlights" })

vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]])   -- make the window biger vertically
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]])   -- make the window smaller vertically
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

--+++++++++ moving highlighted lines +++++++
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "move line down" })
vim.keymap.set("n", "<A-k>", ":m -2<CR>==", { desc = "move line up" })
vim.keymap.set("n", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
vim.keymap.set("n", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move selection up" })

-- +++++ line join &&&& indents ++++
vim.keymap.set("n", "J", "mzJ`z", { desc = "join lines and keep cursor position" })
vim.keymap.set("v", "<", "<gv", { desc = "indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "indent right and reselect" })

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

-- +++++++++ copy full, current file path ++++
vim.keymap.set("n", "<leader>pa", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("Copied filepath:",path)
end, { desc = "copy full file path" })

-- -------------- PLUUUUUUGIIIIIIIINNNSSSSSSS -----------
-- ++++++++ FILEPICKER ++++++++
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
--
-- -- ++++++++ FLOATERM ++++++++
-- vim.keymap.set("n", "<C-g>i", ":FloatermNew --height=0.9 --width=0.9 --wintype=float lazygit<CR>", opts)
-- vim.keymap.set("n", "<C-g>t", ":FloatermNew --height=0.9 --width=0.9 --wintype=float <CR>", opts)
-- vim.keymap.set("n", "<C-g>n", ":FloatermNext<CR>", opts)
-- vim.keymap.set("n", "<C-g>p", ":FloatermPrev<CR>", opts)
-- vim.keymap.set("n", "<C-g>o", ":FloatermShow<CR>", opts)
-- vim.keymap.set("t", "<C-g>o", "<C-\\><C-n>:FloatermToggle<CR>", opts)
--
-- -- +++++++ TELESCOPE +++++++++
-- helper to grab telescope functions without crashing on startup
local function telescope(picker, opts)
  return function()
    local ok, builtin = pcall(require, "telescope.builtin")
    if ok then
      builtin[picker](opts or {})
    else
      vim.notify("Telescope is not installed or loaded yet!", vim.log.levels.WARN)
    end
  end
end

-- short alias for vim.keymap.set
local keymap = vim.keymap.set

-- Telescope Files & Buffers
keymap("n", "<C-f>o", telescope("find_files", { hidden = true }), { desc = "Telescope find files" })
keymap("n", "<C-f>f", telescope("git_files"), { desc = "Telescope search through git files" })
keymap("n", "<C-f>p", telescope("buffers"), { desc = "Telescope buffers" })

-- Search & Discovery
keymap("n", "<leader>gr", telescope("live_grep"), { desc = "Telescope live grep" })
keymap("n", "<leader>tg", telescope("help_tags"), { desc = "Telescope help tags" })

-- LSP Navigation
keymap("n", "<leader>fs", telescope("lsp_document_symbols"), { desc = "Telescope document symbols" })
keymap("n", "<leader>vr", telescope("lsp_references"), { desc = "Telescope references under cursor" })
keymap("n", "<leader>vd", telescope("diagnostics"), { desc = "Telescope diagnostics" })
keymap("n", "<leader>df", telescope("lsp_definitions"), { desc = "Telescope go to definition" })
keymap("n", "<leader>td", telescope("lsp_type_definitions"), { desc = "Telescope go to type definition" })

-- System Histories & Utilities
keymap("n", "<leader>mp", telescope("man_pages"), { desc = "Telescope man pages" })
keymap("n", "<leader>sh", telescope("search_history"), { desc = "Telescope list previous searches" })
keymap("n", "<leader>ch", telescope("command_history"), { desc = "Telescope list previous commands" })

-- Git Integration
keymap("n", "<leader>gs",  telescope("git_stash"), { desc = "Telescope git stash" })
keymap("n", "<leader>gts", telescope("git_status"), { desc = "Telescope git status" }) -- Changed to avoid conflict with <leader>gt

keymap("n", "<leader>gb",  telescope("git_branches"), { desc = "Telescope git branches" })
keymap("n", "<leader>gc",  telescope("git_commits"), { desc = "Telescope git commits" })
keymap("n", "<leader>bc",  telescope("git_bcommits"), { desc = "Telescope buffer commits with diff" })


-- -- +++++++++++++ NVIM DAP +++++++++++++++
-- vim.keymap.set("n", "<F5>", require("dap").continue, { desc = "Debug: Start/Continue" })
-- vim.keymap.set("n", "<F10>", require("dap").step_over, { desc = "Debug: Step Over" })
-- vim.keymap.set("n", "<F11>", require("dap").step_into, { desc = "Debug: Step Into" })
-- vim.keymap.set("n", "<F12>", require("dap").step_out, { desc = "Debug: Step Out" })
-- vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
-- vim.keymap.set("n", "<leader>B", function()
--   require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
-- end, { desc = "Debug: Conditional Breakpoint" })
