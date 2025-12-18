return {
  cmd = { "texlab" },
  capabilities = {
    offsetEncoding = { "utf-8", "utf-16" },
    textDocument = {
      completion = {
        editsNearCursor = true
      }
    }
  },
  filetypes = { "tex", "plaintex", "bib" },
  root_markers = { ".git", ".latexmkrc", "latexmkrc", ".texlabroot", "texlabroot", "Tectonic.toml" }
}
