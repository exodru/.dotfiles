return {
  "miikanissi/modus-themes.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("modus-themes").setup({
      variants = {
        -- modus_operandi = "default", -- Set variant for `modus_operandi` style
        modus_vivendi = "default",       -- Set variant for `modus_vivendi` style
      },
      transparent = true,                -- Transparent background (as supported by the terminal)
      dim_inactive = true,               -- "non-current" windows are dimmed
      line_nr_column_background = false, -- Distinct background colors in line number column. `false` will disable background color and fallback to Normal background
      sign_column_background = false,    -- Distinct background colors in sign column. `false` will disable background color and fallback to Normal background
      background_clear = {
        "float_win",
        "nvim-tree", -- Specifically clear nvim-tree background
        "neo-tree",
        "telescope",
      },
    })

    vim.cmd.colorscheme("modus")

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

    -- Telescope backgrounds (set to none for transparency)
    vim.cmd("hi TelescopeTitle guibg=none")
    vim.cmd("hi TelescopeNormal guibg=none ctermbg=none")
    vim.cmd("hi TelescopePromptNormal guibg=none ctermbg=none")
    vim.cmd("hi TelescopeResultsNormal guibg=none ctermbg=none")
    vim.cmd("hi TelescopePreviewNormal guibg=none ctermbg=none")

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
    vim.cmd("hi Visual guibg=#434C5E")
    vim.cmd("hi VisualNOS guibg=#434C5E")

    -- Force NvimTree transparency
    vim.cmd("hi NvimTreeNormal guibg=none ctermbg=none")
    vim.cmd("hi NvimTreeNormalNC guibg=none ctermbg=none")
    vim.cmd("hi NvimTreeWinSeparator guibg=none ctermbg=none")
    vim.cmd("hi NvimTreeEndOfBuffer guibg=none ctermbg=none")
  end,
}

-- return {
--   'sainnhe/sonokai',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     -- Optionally configure and load the colorscheme
--     -- directly inside the plugin declaration.
--     vim.g.sonokai_enable_italic = true
--     vim.g.sonokai_transparent_background = 2
--     vim.cmd.colorscheme("sonokai")
--
--     local accent = "#72CCE8" -- Blink CMP
--     vim.cmd("hi BlinkCmpMenu guibg=none ctermbg=none")
--     vim.cmd("hi BlinkCmpDoc guibg=none ctermbg=none")
--     vim.cmd("hi BlinkCmpSignatureHelp guibg=none ctermbg=none")
--     vim.cmd("hi BlinkCmpMenuBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi BlinkCmpDocBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi BlinkCmpSignatureHelpBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi BlinkCmpSignatureHelpActiveParameter guibg=none ctermbg=none guifg=#28F731")
--     vim.cmd("hi BlinkCmpKind guibg=none ctermbg=none guifg=#FFD34F")
--     vim.cmd("hi BlinkCmpLabelDetail guibg=none ctermbg=none guifg=" .. accent)
--
--     -- Telescope window borders
--     vim.cmd("hi TelescopeBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi TelescopePromptBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi TelescopeResultsBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi TelescopePreviewBorder guibg=none ctermbg=none guifg=" .. accent)
--
--     -- Telescope backgrounds (set to none for transparency)
--     vim.cmd("hi TelescopeTitle guibg=none")
--     vim.cmd("hi TelescopeNormal guibg=none ctermbg=none")
--     vim.cmd("hi TelescopePromptNormal guibg=none ctermbg=none")
--     vim.cmd("hi TelescopeResultsNormal guibg=none ctermbg=none")
--     vim.cmd("hi TelescopePreviewNormal guibg=none ctermbg=none")
--
--     -- Other default neovim highlights
--     vim.cmd("hi Normal guibg=none ctermbg=none")
--     vim.cmd("hi NormalNC guibg=none ctermbg=none")
--     vim.cmd("hi NormalFloat guibg=none ctermbg=none")
--     vim.cmd("hi FloatBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi LineNr guibg=none ctermbg=none")
--     vim.cmd("hi Folded guibg=none ctermbg=none")
--     vim.cmd("hi NonText guibg=none ctermbg=none")
--     vim.cmd("hi SpecialKey guibg=none ctermbg=none")
--     vim.cmd("hi VertSplit guibg=none ctermbg=none")
--     vim.cmd("hi CursorLineNr guibg=none ctermbg=none")
--     vim.cmd("hi StatusLine guibg=none ctermbg=none")
--     vim.cmd("hi EndOfBuffer guibg=none ctermbg=none")
--     vim.cmd("hi SignColumn guibg=none ctermbg=none")
--     vim.cmd("hi Visual guibg=#434C5E")
--     vim.cmd("hi VisualNOS guibg=#434C5E")
--   end
-- }

-- return {
--   "datsfilipe/vesper.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("vesper").setup({
--       transparent = true,
--     })
--     vim.cmd.colorscheme("vesper")
--
--     local accent = "#32BD98" -- Blink CMP
--     vim.cmd("hi BlinkCmpMenu guibg=none ctermbg=none")
--     vim.cmd("hi BlinkCmpDoc guibg=none ctermbg=none")
--     vim.cmd("hi BlinkCmpSignatureHelp guibg=none ctermbg=none")
--     vim.cmd("hi BlinkCmpMenuBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi BlinkCmpDocBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi BlinkCmpSignatureHelpBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi BlinkCmpSignatureHelpActiveParameter guibg=none ctermbg=none guifg=#28F731")
--     vim.cmd("hi BlinkCmpKind guibg=none ctermbg=none guifg=#FFD34F")
--     vim.cmd("hi BlinkCmpLabelDetail guibg=none ctermbg=none guifg=" .. accent)
--
--     -- Telescope window borders
--     vim.cmd("hi TelescopeBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi TelescopePromptBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi TelescopeResultsBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi TelescopePreviewBorder guibg=none ctermbg=none guifg=" .. accent)
--
--     -- Telescope backgrounds (set to none for transparency)
--     vim.cmd("hi TelescopeTitle guibg=none")
--     vim.cmd("hi TelescopeNormal guibg=none ctermbg=none")
--     vim.cmd("hi TelescopePromptNormal guibg=none ctermbg=none")
--     vim.cmd("hi TelescopeResultsNormal guibg=none ctermbg=none")
--     vim.cmd("hi TelescopePreviewNormal guibg=none ctermbg=none")
--
--     -- Other default neovim highlights
--     vim.cmd("hi Normal guibg=none ctermbg=none")
--     vim.cmd("hi NormalNC guibg=none ctermbg=none")
--     vim.cmd("hi NormalFloat guibg=none ctermbg=none")
--     vim.cmd("hi FloatBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi LineNr guibg=none ctermbg=none")
--     vim.cmd("hi Folded guibg=none ctermbg=none")
--     vim.cmd("hi NonText guibg=none ctermbg=none")
--     vim.cmd("hi SpecialKey guibg=none ctermbg=none")
--     vim.cmd("hi VertSplit guibg=none ctermbg=none")
--     vim.cmd("hi CursorLineNr guibg=none ctermbg=none")
--     vim.cmd("hi StatusLine guibg=none ctermbg=none")
--     vim.cmd("hi EndOfBuffer guibg=none ctermbg=none")
--     vim.cmd("hi SignColumn guibg=none ctermbg=none")
--   end,
-- }

-- return {
--   "rebelot/kanagawa.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("kanagawa").setup({
--       transparent = true,
--     })
--     vim.cmd.colorscheme("kanagawa")
--
--     local accent = "#98BB6C" -- Blink CMP
--     vim.cmd("hi BlinkCmpMenu guibg=none ctermbg=none")
--     vim.cmd("hi BlinkCmpDoc guibg=none ctermbg=none")
--     vim.cmd("hi BlinkCmpSignatureHelp guibg=none ctermbg=none")
--     vim.cmd("hi BlinkCmpMenuBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi BlinkCmpDocBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi BlinkCmpSignatureHelpBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi BlinkCmpSignatureHelpActiveParameter guibg=none ctermbg=none guifg=#28F731")
--     vim.cmd("hi BlinkCmpKind guibg=none ctermbg=none guifg=#FFD34F")
--     vim.cmd("hi BlinkCmpLabelDetail guibg=none ctermbg=none guifg=" .. accent)
--
--     -- Telescope window borders
--     vim.cmd("hi TelescopeBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi TelescopePromptBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi TelescopeResultsBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi TelescopePreviewBorder guibg=none ctermbg=none guifg=" .. accent)
--
--     -- Telescope backgrounds (set to none for transparency)
--     vim.cmd("hi TelescopeTitle guibg=none")
--     vim.cmd("hi TelescopeNormal guibg=none ctermbg=none")
--     vim.cmd("hi TelescopePromptNormal guibg=none ctermbg=none")
--     vim.cmd("hi TelescopeResultsNormal guibg=none ctermbg=none")
--     vim.cmd("hi TelescopePreviewNormal guibg=none ctermbg=none")
--
--     -- Other default neovim highlights
--     vim.cmd("hi Normal guibg=none ctermbg=none")
--     vim.cmd("hi NormalNC guibg=none ctermbg=none")
--     vim.cmd("hi NormalFloat guibg=none ctermbg=none")
--     vim.cmd("hi FloatBorder guibg=none ctermbg=none guifg=" .. accent)
--     vim.cmd("hi LineNr guibg=none ctermbg=none")
--     vim.cmd("hi Folded guibg=none ctermbg=none")
--     vim.cmd("hi NonText guibg=none ctermbg=none")
--     vim.cmd("hi SpecialKey guibg=none ctermbg=none")
--     vim.cmd("hi VertSplit guibg=none ctermbg=none")
--     vim.cmd("hi CursorLineNr guibg=none ctermbg=none")
--     vim.cmd("hi StatusLine guibg=none ctermbg=none")
--     vim.cmd("hi EndOfBuffer guibg=none ctermbg=none")
--     vim.cmd("hi SignColumn guibg=none ctermbg=none")
--   end,
-- }
