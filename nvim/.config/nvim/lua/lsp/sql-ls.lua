return {
  cmd = { "sql-language-server", "up", "--method", "stdio" },
  filetypes = { "sql", "mysql" },
  init_options = {
    provideFormatter = true
  },
  root_markers = { ".sqllsrc.json" },
  settings = {},
}
