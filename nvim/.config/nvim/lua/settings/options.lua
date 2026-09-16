-- this local is equal to :set in vim
local set = vim.opt

-- colorscheme
-- vim.cmd [[colorscheme moonfly]]

-- map leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- disable netrw cause i use nvim-tree filepicker
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- settings --
set.termguicolors = true
scriptencoding = "utf-8"
set.encoding = "utf-8"
set.fileencoding = "utf-8"
set.autoread = true
set.backupcopy = "yes"
set.expandtab = true
set.shiftwidth = 2
set.softtabstop = 2
set.tabstop = 2
set.updatetime = 150
set.timeoutlen = 250
set.exrc = true
set.nu = true
set.relativenumber = true
set.numberwidth = 6
set.statuscolumn = "%s %{v:lnum} %{v:relnum} "
set.hidden = true -- allow hidden buffers
set.showmode = false
set.incsearch = true
set.hlsearch = false
set.wrap = true
set.scrolloff = 8
set.errorbells = false
set.ruler = true
set.clipboard = "unnamedplus" -- use system keyboard
set.breakindent = true         -- keep indentation when lines break
set.breakindentopt = "shift:2" -- but shift it by 2 spaces
set.linebreak = true           -- break only at specific characters, :h breakat
set.completeopt = {
  "menuone",
  "noinsert",
  "noselect",
}
set.autoindent = true
set.smartindent = true
set.magic = true
set.number = true
set.visualbell = true
set.splitright = true
set.signcolumn = "yes"
-- set.cursorcolumn = true
set.cursorline = true
-- set.colorcolumn = "120"
set.cmdheight = 0
set.scroll = 14
set.laststatus = 3
set.listchars = {
  eol = "↴",
  extends = "›",
  precedes = "‹",
  nbsp = "␣",
  trail = "·",
  tab = "• ",
}
set.list = true
vim.o.winborder = "rounded"
set.fillchars = { eob = " " } -- hide "~" on empty lines

-- persist undo between files and directories (persist, if we go back to a file in another directory - we want to be able to undo it)
local undodir = vim.fn.expand("~/.vim/undodir")
if 
  vim.fn.isdirectory(undodir) == 0 -- create if nonexistent
then 
  vim.fn.mkdir(undodir, "p")
end

set.backup = false -- dont create backup files
set.writebackup = false -- do not write to a backup file
set.swapfile = false -- do not create a swapfile
set.undofile = true
set.undodir = undodir
set.autoread = true -- autoreload changes if outside of nvim
set.autowrite = false -- do not autosave
set.errorbells = false -- no error sounds
set.backspace = "indent,eol,start" -- better backspace behavoiour
set.autochdir = false -- dont autochange dirs
set.mouse = "a" -- enable mouse support
set.iskeyword:append("-") -- include - in words (takes the - char as a word)
set.path:append("**") -- include subdirs in search
set.modifiable = true -- allow buffer modificaitons
set.selection = "inclusive" -- makes it so that last char in selection is included (when highlighted to yank)

--- folding, splits
set.foldmethod = "expr" -- use expression for folding
set.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use tresitter for folding
set.foldlevel = 99 -- start with all folds open

set.splitbelow = true -- horizontal splits go below
set.splitright = true -- vertical splits go right

set.wildmenu = true -- tab completion
set.wildmode = "longest:full,full" -- complete longest common match, full completion list, cycle thru with Tab
set.diffopt:append("linematch:60") -- improve diff display
set.redrawtime = 10000
set.maxmempattern = 20000

-- +++++++ AUTOCOMMANDS +++++
-- highlight on yank
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })')
vim.cmd([[hi Visual guifg=#101010 guibg=#F6AC1F gui=none]])


-- golang stuff
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.go",
--   callback = function()
--     -- get the gopls client for the current buffer
--     local clients = vim.lsp.get_clients({ bufnr = 0, name = "gopls" })
--     if #clients == 0 then return end
--     local client = clients[1]
--
--     -- pass the client's offset_encoding to make_range_params local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
--     params.context = { only = { "source.organizeImports" } }
--
--     -- request the code action synchronously
--     local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
--     for cid, res in pairs(result or {}) do
--       for _, r in pairs(res.result or {}) do
--         if r.edit then
--           local enc = vim.lsp.get_client_by_id(cid).offset_encoding or "utf-16"
--           vim.lsp.util.apply_workspace_edit(r.edit, enc)
--         end
--       end
--     end
--
--     -- format the code
--     vim.lsp.buf.format({ async = false })
--   end,
-- })



-- Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi blandit, neque quis elementum accumsan, ex nibh pellentesque ante, non gravida lorem lectus non nibh. Sed interdum tellus sed nulla consectetur, non laoreet sem pretium. Suspendisse efficitur tempus enim nec ullamcorper. Nam dignissim, lacus ut congue tincidunt, nunc odio ultrices quam, eget mattis odio turpis nec magna. Integer in enim in lectus egestas interdum malesuada sed quam. Etiam ultrices placerat dui, ac congue purus egestas at. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras dictum leo magna, eu consectetur dui suscipit ac. Morbi feugiat eu ex eu consectetur. Praesent tortor ligula, cursus a odio eget, finibus efficitur elit. Aenean finibus lacus a euismod elementum. Aenean non justo augue. Sed risus neque, venenatis sed purus eu, venenatis vulputate odio. Suspendisse scelerisque, neque a mattis hendrerit, lectus felis sagittis leo, id venenatis erat ligula ac justo.
--
-- Praesent luctus massa leo, vel eleifend tellus euismod ut. Sed dolor eros, mattis vitae felis ut, pretium dignissim leo. Donec fringilla iaculis justo, a efficitur arcu vehicula non. Nunc nec dictum massa, sit amet sollicitudin est. Ut a orci justo. Vestibulum eu diam et ipsum hendrerit gravida. In vitae venenatis enim, id venenatis justo. Donec commodo porta ullamcorper.
--
-- Donec eu accumsan arcu. Proin id tellus urna. Donec odio urna, varius nec odio a, ullamcorper placerat turpis. Curabitur quis magna eget erat vulputate condimentum. Quisque eget consectetur erat, vel cursus ligula. Curabitur blandit orci suscipit rhoncus fermentum. Pellentesque fermentum ornare ante, non condimentum felis facilisis et. Duis in velit eu orci bibendum iaculis. Nulla faucibus ex sed pellentesque sodales. Vivamus interdum lectus quis arcu cursus, at placerat quam rhoncus. Quisque vel ex eget massa iaculis vehicula ac a justo. Nullam tincidunt rutrum felis, vel malesuada nisl mattis non. Mauris at tempus dui. Suspendisse potenti.
--
-- Praesent id nisi tortor. In ex leo, interdum eleifend sagittis nec, pellentesque non velit. Praesent sed tincidunt purus. Maecenas tristique, diam vitae dictum sagittis, diam ligula sollicitudin turpis, et tristique lorem turpis id tortor. In tincidunt sagittis nunc. Suspendisse lorem dolor, fermentum sed nibh et, bibendum facilisis urna. Suspendisse rutrum maximus ex, eget vehicula justo pulvinar vitae. Integer suscipit placerat ligula et imperdiet. Etiam viverra purus ac pretium molestie. Donec nulla ex, suscipit sed vestibulum at, molestie sed purus. In sed sollicitudin lectus.
--
-- Aliquam at eros accumsan, euismod orci eu, viverra urna. Aliquam erat volutpat. Morbi tempus diam id lacus viverra aliquam vel a turpis. Vestibulum ut laoreet lorem. Sed turpis odio, dignissim in dolor ut, fringilla aliquet urna. Morbi et facilisis lorem, ut finibus neque. Integer congue eu velit non tempus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ut pulvinar ante. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In a posuere orci. Suspendisse ac sem viverra, fringilla lectus ac, imperdiet dolor. Ut cursus dui sed odio ornare tristique. Suspendisse potenti.
