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

-- Auto-organize imports for Go on save (Fixed for Neovim 0.11)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    -- 1. Get the gopls client for the current buffer
    local clients = vim.lsp.get_clients({ bufnr = 0, name = "gopls" })
    if #clients == 0 then return end
    local client = clients[1]

    -- 2. Pass the client's offset_encoding to make_range_params
    local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
    params.context = { only = { "source.organizeImports" } }

    -- 3. Request the code action synchronously
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = vim.lsp.get_client_by_id(cid).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end

    -- 4. Finally, format the code
    vim.lsp.buf.format({ async = false })
  end,
})
