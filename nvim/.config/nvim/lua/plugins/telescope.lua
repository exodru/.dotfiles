local actions = require("telescope.actions")

local open_after_tree = function(prompt_bufnr)
  vim.defer_fn(function()
    actions.select_default(prompt_bufnr)
  end, 100) -- Delay allows filetype and plugins to settle before opening
end

local telesconfig = function()
  require("telescope").setup({
    pickers = {
      find_files = {
        hidden = false
      }
    },
    defaults = {
      mappings = {
        i = { ["<CR>"] = open_after_tree },
        n = { ["<CR>"] = open_after_tree },
      },
    },
  })
end

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.3',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = telesconfig
}
