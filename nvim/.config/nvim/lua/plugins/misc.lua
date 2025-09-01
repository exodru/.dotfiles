-- Various small plugins that dont have a huge impact but improves my personal DX.
return {
  { "windwp/nvim-ts-autotag" },
  -- {
  --   'github/copilot.vim',
  --   init = function()
  --     vim.g.copilot_no_tab_map = true
  --     vim.g.copilot_assume_mapped = true
  --   end,
  --   config = function()
  --     vim.keymap.set('i', '<C-e>', [[copilot#Accept("\<CR>")]], {
  --       silent = true,
  --       expr = true,
  --       script = true,
  --       replace_keycodes = false,
  --     })
  --   end,
  -- },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "as",           -- replaces `ys` (asiw - add surround in words + symbol, ex: asiw")
          normal_cur = "ass",      -- replaces `yss` (ass - add surrounding sentence + symbol, ex: ass")
          normal_line = "aS",      -- replaces `yS`
          normal_cur_line = "aSS", -- replaces `ySS`
          visual = "S",
          delete = "ds",
          change = "cs",
        },
      })
    end
  },
  {
    "numToStr/Comment.nvim",
    opts = {},
    lazy = false,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup({})
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  }
}
