-- this local is equal to :set in vim
local set = vim.opt

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
set.updatetime = 50
set.exrc = true
set.nu = true
set.relativenumber = true
set.numberwidth = 6
vim.opt.statuscolumn = "%s %{v:lnum} %{v:relnum} "
set.hidden = true
set.showmode = false
set.incsearch = true
set.swapfile = false
set.hlsearch = false
set.wrap = true
set.scrolloff = 8
set.errorbells = false
set.ruler = true
set.clipboard = "unnamedplus"
set.breakindent = true -- keep indentation when lines break
set.breakindentopt = "shift:2" -- but shift it by 2 spaces
set.linebreak = true -- break only at specific characters, :h breakat
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
-- set.cursorline = true
-- set.colorcolumn = "120"
set.cmdheight = 0
vim.opt.scroll = 14
vim.opt.laststatus = 3
vim.opt.listchars = {
	eol = "↴",
	extends = "›",
	precedes = "‹",
	nbsp = "␣",
	trail = "·",
	tab = "• ",
}
vim.opt.list = true
vim.o.winborder = "rounded"

-- highlight on yank
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })')
vim.cmd([[hi Visual guifg=#101010 guibg=#F6AC1F gui=none]])
