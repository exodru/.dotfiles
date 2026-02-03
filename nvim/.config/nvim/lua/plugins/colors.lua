-- return {
-- 	"datsfilipe/vesper.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("vesper").setup({
-- 			transparent = true,
-- 		})
-- 		vim.cmd.colorscheme("vesper")
--
-- 		local accent = "#32BD98" -- Blink CMP
-- 		vim.cmd("hi BlinkCmpMenu guibg=none ctermbg=none")
-- 		vim.cmd("hi BlinkCmpDoc guibg=none ctermbg=none")
-- 		vim.cmd("hi BlinkCmpSignatureHelp guibg=none ctermbg=none")
-- 		vim.cmd("hi BlinkCmpMenuBorder guibg=none ctermbg=none guifg=" .. accent)
-- 		vim.cmd("hi BlinkCmpDocBorder guibg=none ctermbg=none guifg=" .. accent)
-- 		vim.cmd("hi BlinkCmpSignatureHelpBorder guibg=none ctermbg=none guifg=" .. accent)
-- 		vim.cmd("hi BlinkCmpSignatureHelpActiveParameter guibg=none ctermbg=none guifg=#28F731")
-- 		vim.cmd("hi BlinkCmpKind guibg=none ctermbg=none guifg=#FFD34F")
-- 		vim.cmd("hi BlinkCmpLabelDetail guibg=none ctermbg=none guifg=" .. accent)
--
-- 		-- Telescope window borders
-- 		vim.cmd("hi TelescopeBorder guibg=none ctermbg=none guifg=" .. accent)
-- 		vim.cmd("hi TelescopePromptBorder guibg=none ctermbg=none guifg=" .. accent)
-- 		vim.cmd("hi TelescopeResultsBorder guibg=none ctermbg=none guifg=" .. accent)
-- 		vim.cmd("hi TelescopePreviewBorder guibg=none ctermbg=none guifg=" .. accent)
--
-- 		-- Telescope backgrounds (set to none for transparency)
-- 		vim.cmd("hi TelescopeTitle guibg=none")
-- 		vim.cmd("hi TelescopeNormal guibg=none ctermbg=none")
-- 		vim.cmd("hi TelescopePromptNormal guibg=none ctermbg=none")
-- 		vim.cmd("hi TelescopeResultsNormal guibg=none ctermbg=none")
-- 		vim.cmd("hi TelescopePreviewNormal guibg=none ctermbg=none")
--
-- 		-- Other default neovim highlights
-- 		vim.cmd("hi Normal guibg=none ctermbg=none")
-- 		vim.cmd("hi NormalNC guibg=none ctermbg=none")
-- 		vim.cmd("hi NormalFloat guibg=none ctermbg=none")
-- 		vim.cmd("hi FloatBorder guibg=none ctermbg=none guifg=" .. accent)
-- 		vim.cmd("hi LineNr guibg=none ctermbg=none")
-- 		vim.cmd("hi Folded guibg=none ctermbg=none")
-- 		vim.cmd("hi NonText guibg=none ctermbg=none")
-- 		vim.cmd("hi SpecialKey guibg=none ctermbg=none")
-- 		vim.cmd("hi VertSplit guibg=none ctermbg=none")
-- 		vim.cmd("hi CursorLineNr guibg=none ctermbg=none")
-- 		vim.cmd("hi StatusLine guibg=none ctermbg=none")
-- 		vim.cmd("hi EndOfBuffer guibg=none ctermbg=none")
-- 		vim.cmd("hi SignColumn guibg=none ctermbg=none")
-- 	end,
-- }

return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require('nightfox').setup({
      options = {
        transparent = true,     -- Disable setting background
        terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = false,   -- Non focused panes set to alternative background
      }
    })
    vim.cmd.colorscheme('nightfox')

    local accent = "#7A9CC8"
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

    -- Telescope backgrounds (set to none for transparency)
    vim.cmd("hi TelescopeTitle guibg=none")
    vim.cmd("hi TelescopeNormal guibg=none ctermbg=none")
    vim.cmd("hi TelescopePromptNormal guibg=none ctermbg=none")
    vim.cmd("hi TelescopeResultsNormal guibg=none ctermbg=none")
    vim.cmd("hi TelescopePreviewNormal guibg=none ctermbg=none")

    -- lualine tabline bg
    vim.api.nvim_set_hl(0, "LualineTablineFill", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "TabLine", { bg = "NONE" })

    -- Other default neovim highlights
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
  end,
}
