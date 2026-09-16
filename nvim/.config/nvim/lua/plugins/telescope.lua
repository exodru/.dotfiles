vim.pack.add({
  { src='https://github.com/nvim-telescope/telescope.nvim', name = "telescope" },
  { src='https://github.com/nvim-lua/plenary.nvim'},
  { src='https://github.com/nvim-telescope/telescope-fzf-native.nvim', build = 'make' },  
})


require("telescope").setup({
    defaults = {
      -- hide the .git folder even when 'hidden = true' is set
      file_ignore_patterns = { "%.git/" },
      window = { border = true },
    },
    pickers = {
      find_files = {
        theme = "ivy",
        hidden = false,
      },
      live_grep = {
        theme = "ivy",
      },
    },
})

