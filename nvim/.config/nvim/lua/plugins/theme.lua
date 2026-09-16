-- 1. Register the moonfly plugin
vim.pack.add({
  { src = "https://github.com/bluz71/vim-moonfly-colors", name = "moonfly" }
})

-- 2. Check if moonfly is loaded before configuring options
local status_ok, _ = pcall(require, "moonfly")
if status_ok then
  -- Configure moonfly options (must be set before calling the colorscheme)
  vim.g.moonflyTransparent = true
  vim.g.moonflyNormalFloat = true
  
  -- Apply the colorscheme
  vim.cmd.colorscheme("moonfly")
else
  -- Fallback layout so Neovim works during background downloading
  vim.cmd.colorscheme("habamax")
end

-- Custom highlight overrides
local accent = "#349DA6" -- Blink CMP

vim.cmd("hi BlinkCmpMenu guibg=none ctermbg=none")
vim.cmd("hi BlinkCmpDoc guibg=none ctermbg=none")
vim.cmd("hi BlinkCmpSignatureHelp guibg=none ctermbg=none")
vim.cmd("hi BlinkCmpMenuBorder guibg=none ctermbg=none guifg=" .. accent)
vim.cmd("hi BlinkCmpDocBorder guibg=none ctermbg=none guifg=" .. accent)
vim.cmd("hi BlinkCmpSignatureHelpBorder guibg=none ctermbg=none guifg=" .. accent)
vim.cmd("hi BlinkCmpSignatureHelpActiveParameter guibg=none ctermbg=none guifg=#28F731")
vim.cmd("hi BlinkCmpKind guibg=none ctermbg=none guifg=#FFD34F")
vim.cmd("hi BlinkCmpLabelDetail guibg=none ctermbg=none guifg=" .. accent)

-- Telescope window borders
vim.cmd("hi TelescopeBorder guibg=none ctermbg=none guifg=" .. accent)
vim.cmd("hi TelescopePromptBorder guibg=none ctermbg=none guifg=" .. accent)
vim.cmd("hi TelescopeResultsBorder guibg=none ctermbg=none guifg=" .. accent)
vim.cmd("hi TelescopePreviewBorder guibg=none ctermbg=none guifg=" .. accent)

-- Telescope backgrounds
vim.cmd("hi TelescopeTitle guibg=none")
vim.cmd("hi TelescopeNormal guibg=none ctermbg=none")
vim.cmd("hi TelescopePromptNormal guibg=none ctermbg=none")
vim.cmd("hi TelescopeResultsNormal guibg=none ctermbg=none")
vim.cmd("hi TelescopePreviewNormal guibg=none ctermbg=none")

-- Default Neovim highlights
vim.cmd("hi Normal guibg=none ctermbg=none")
vim.cmd("hi NormalNC guibg=none ctermbg=none")
vim.cmd("hi NormalFloat guibg=none ctermbg=none")
vim.cmd("hi FloatBorder guibg=none ctermbg=none guifg=" .. accent)
vim.cmd("hi LineNr guibg=none ctermbg=none")
vim.cmd("hi Folded guibg=none ctermbg=none")
vim.cmd("hi NonText guibg=none ctermbg=none")
vim.cmd("hi SpecialKey guibg=none ctermbg=none")
vim.cmd("hi VertSplit guibg=none ctermbg=none")
vim.cmd("hi CursorLineNr guibg=none ctermbg=none")
vim.cmd("hi StatusLine guibg=none ctermbg=none")
vim.cmd("hi EndOfBuffer guibg=none ctermbg=none")
vim.cmd("hi SignColumn guibg=none ctermbg=none")
vim.cmd("hi Visual guibg=#434C5E")
vim.cmd("hi VisualNOS guibg=#434C5E")

-- Force NvimTree transparency
vim.cmd("hi NvimTreeNormal guibg=none ctermbg=none")
vim.cmd("hi NvimTreeNormalNC guibg=none ctermbg=none")
vim.cmd("hi NvimTreeWinSeparator guibg=none ctermbg=none")
vim.cmd("hi NvimTreeEndOfBuffer guibg=none ctermbg=none")

