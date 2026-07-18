return {
  "saghen/blink.cmp",
  build = function()
    -- build the fuzzy matcher, optionally add a timeout to `pwait(timeout_ms)`
    -- you can use `gb` in `:Lazy` to rebuild the plugin as needed
    require('blink.cmp').build():pwait()
  end,
  cond = not vim.g.vscode,
  lazy = false,
  dependencies = { { "L3MON4D3/LuaSnip", version = "v2.*" }, { "saghen/blink.lib" } },
  opts = {
    snippets = { preset = "luasnip" },
    keymap = {
      preset = "default",
      ["<C-e>"] = { "select_and_accept", "fallback" },
      ["<C-y>"] = { "hide" },
      ["<C-l>"] = { "snippet_forward", "fallback" },
      ["<C-h>"] = { "snippet_backward", "fallback" },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "rust" },
    completion = {
      keyword = { range = "full" },
      list = { selection = { preselect = true, auto_insert = false } },
      ghost_text = { enabled = true },
      -- Show documentation when selecting a completion item
      documentation = { auto_show = true, auto_show_delay_ms = 250 },
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { "label",     "label_description", gap = 1 },
            { "kind_icon", "kind" },
          },
        },
      },
    },
    signature = { enabled = true },
  },
}
