local util = require("lspconfig.util")

return {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", "CMakeLists.txt", ".git"),
  capabilities = {},
}

