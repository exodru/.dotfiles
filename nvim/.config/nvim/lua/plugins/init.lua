local all_specs = {}
local plugins_path = vim.fn.stdpath("config") .. "/lua/plugins"

-- dir scanning
for name, kind in vim.fs.dir(plugins_path) do
  if kind == "file" and name:match("%.lua$") and name ~= "init.lua" then
    local mod_name = name:sub(1, -5)
    local success, spec = pcall(require, "plugins." .. mod_name)
    if success and type(spec) == "table" then
      -- unpack nested array lists safely (like multiple dependencies of various plugins)
      if spec[1] and type(spec[1]) == "table" then
        for _, sub_spec in ipairs(spec) do
          table.insert(all_specs, sub_spec)
        end
      else
        table.insert(all_specs, spec)
      end
    end
  end
end

-- load the plugins automatically in the bg
vim.pack.add(all_specs, { force = true })
