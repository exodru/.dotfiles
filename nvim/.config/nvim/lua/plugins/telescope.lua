-- in your plugin configuration file (likely init.lua or plugins.lua)
return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',  -- Ensure you're using the correct version
    dependencies = { 'nvim-lua/plenary.nvim' },  -- Plenary is a dependency for Telescope
    config = function()
      local actions = require('telescope.actions')

      local open_after_tree = function(prompt_bufnr)
        vim.defer_fn(function()
          actions.select_default(prompt_bufnr)
        end, 100) -- Delay allows filetype and plugins to settle before opening
      end

      require('telescope').setup({
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
  }
}
