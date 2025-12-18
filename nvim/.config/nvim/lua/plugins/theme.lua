return {
  "vague2k/vague.nvim",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other plugins
  config = function()
    -- NOTE: you do not need to call setup if you don't want to.
    require("vague").setup({
      transparent = true,
    })
    vim.cmd("colorscheme vague")
    vim.cmd([[ highlight TelescopeBorder guibg=none ]])
    vim.cmd([[ highlight TelescopeTitle guibg=none ]])

    vim.cmd("hi Normal guibg=none ctermbg=none")
    vim.cmd("hi NormalNC guibg=none ctermbg=none")
    vim.cmd("hi NormalFloat guibg=none ctermbg=none")
    vim.cmd("hi LineNr guibg=none ctermbg=none")
    vim.cmd("hi Folded guibg=none ctermbg=none")
    vim.cmd("hi NonText guibg=none ctermbg=none")
    vim.cmd("hi SpecialKey guibg=none ctermbg=none")
    vim.cmd("hi VertSplit guibg=none ctermbg=none")
    vim.cmd("hi CursorLineNr guibg=none ctermbg=none")
    vim.cmd("hi StatusLine guibg=none ctermbg=none")
    vim.cmd("hi EndOfBuffer guibg=none ctermbg=none")
    vim.cmd("hi SignColumn guibg=none ctermbg=none")
  end
}

-- return {
--   "RRethy/base16-nvim",
--   lazy = false,    -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other plugins
--
--   config = function()
--     require('base16-colorscheme').with_config({
--       telescope = false,
--       indentblankline = true,
--       notify = true,
--       ts_rainbow = true,
--       cmp = true,
--       illuminate = true,
--       dapui = true,
--     })
--
--     -- #jblow type green palette
--     -- local bg = "#151e19"
--     -- local accent = "#25352b"
--     -- local accent2 = "#202d25" -- highlight and lualine
--
--
--     -- monochrome
--     local bg = "#1b1b1b"
--     local accent = "#404040"
--     local accent2 = "#323232" -- highlight and lualine
--
--     local text = "#e9e9eb"
--     local dark_text = "#64676c" -- comments, line numbers
--
--     local keyword = "#b7efeb"
--     local func = "#93e2b9"
--     local types = "#87d6e9"
--     local constant = "#e5d5ab"
--
--     local for_tesing = "#FF0000"
--
--     require('base16-colorscheme').setup({
--       telescope = true,
--       indentblankline = true,
--       notify = true,
--       ts_rainbow = true,
--       cmp = true,
--       illuminate = true,
--       dapui = true,
--
--       base00 = bg,
--       base01 = accent,
--       base02 = accent2,
--       base03 = dark_text,
--       base04 = dark_text,
--       base05 = text,
--       base06 = for_tesing,
--       base07 = for_tesing,
--       base08 = text,
--       base09 = constant,
--       base0A = types,
--       base0B = constant,
--       base0C = text,
--       base0D = func,
--       base0E = keyword,
--       base0F = text
--     })
--     -- vim.cmd("colorscheme base16-")
--     vim.cmd([[ highlight TelescopeBorder guibg=none ]])
--     vim.cmd([[ highlight TelescopeTitle guibg=none ]])
--
--     vim.cmd("hi Normal guibg=none ctermbg=none")
--     vim.cmd("hi NormalNC guibg=none ctermbg=none")
--     vim.cmd("hi NormalFloat guibg=none ctermbg=none")
--     vim.cmd("hi LineNr guibg=none ctermbg=none")
--     vim.cmd("hi Folded guibg=none ctermbg=none")
--     vim.cmd("hi NonText guibg=none ctermbg=none")
--     vim.cmd("hi SpecialKey guibg=none ctermbg=none")
--     vim.cmd("hi VertSplit guibg=none ctermbg=none")
--     vim.cmd("hi CursorLineNr guibg=none ctermbg=none")
--     vim.cmd("hi StatusLine guibg=none ctermbg=none")
--     vim.cmd("hi EndOfBuffer guibg=none ctermbg=none")
--     vim.cmd("hi SignColumn guibg=none ctermbg=none")
--   end
-- }


-- return {}
