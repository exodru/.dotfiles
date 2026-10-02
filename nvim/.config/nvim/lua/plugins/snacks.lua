vim.pack.add({
	{ src = "https://github.com/folke/snacks.nvim" },
})

require("snacks").setup({
	-- image = {
	-- 	resolve = function(path, src)
	-- 		local api = require("obsidian.api")
	-- 		if api.path_is_note(path) then
	-- 			return api.resolve_attachment_path(src)
	-- 		end
	-- 	end,
	-- 	enabled = true,
	-- },

	image = {
		enabled = true,

		-- Custom resolver to strip out syntax flags like |100 so paths don't break
		resolve = function(ctx, src)
			local clean_src = src:match("([^|]+)") or src

			-- Fallback to obsidian attachment path resolution engine
			local ok, obs_api = pcall(require, "obsidian.api")
			if ok and obs_api.path_is_note and obs_api.path_is_note(ctx) then
				return tostring(obs_api.resolve_attachment_path(clean_src))
			end
			return clean_src
		end,

		doc = {
			inline = true,

			-- Controls the rendering box logic layout constraints
			-- Setting these limits ensures images fit cleanly inside terminal borders
			max_width = 90, -- Reduces the text block layout size (default is 80 columns)
			max_height = 45, -- Scales the vertical terminal grids down proportionally
		},
	},
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.md",
	callback = function()
		local client = require("obsidian").get_client()
		local vault_path = tostring(client.dir)
		local attachments_dir = vault_path .. "/external_attachments"

		-- Ensure the external_attachments directory exists before checking
		if vim.fn.isdirectory(attachments_dir) == 1 then
			local handle = vim.loop.fs_scandir(attachments_dir)
			if handle then
				while true do
					local name, type = vim.loop.fs_scandir_next(handle)
					if not name then
						break
					end

					if type == "file" and (name:match("%.png$") or name:match("%.jpg$")) then
						-- Run a fast ripgrep/grep search through your vault files

						-- If ripgrep returns no text instances, safely remove the file
						if vim.v.shell_error ~= 0 then
							local file_to_delete = attachments_dir .. "/" .. name
							os.remove(file_to_delete)
							vim.notify("Removed orphaned image: " .. name, vim.log.levels.INFO)
						end
					end
				end
			end
		end
	end,
})
