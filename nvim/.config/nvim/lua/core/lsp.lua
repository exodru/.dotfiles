-- lua/core/lsp.lua
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Mason for installing LSPs
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Extra capabilities for nvim-cmp
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		local lspconfig = require("lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- Capabilities for nvim-cmp
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		-- LSP keymaps and highlight on attach
		local on_attach = function(client, bufnr)
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
			end

			map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
			map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
			map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
			map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
			map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
			map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
			map("K", vim.lsp.buf.hover, "Hover Documentation")
			map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
			map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
			map("<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "[W]orkspace [L]ist Folders")

			-- Highlight references
			if client.supports_method("textDocument/documentHighlight") then
				local hl_augroup = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = bufnr,
					group = hl_augroup,
					callback = vim.lsp.buf.document_highlight,
				})
				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = bufnr,
					group = hl_augroup,
					callback = vim.lsp.buf.clear_references,
				})
			end

			-- Toggle inlay hints if supported
			if client.supports_method("textDocument/inlayHint") then
				map("<leader>th", function()
					vim.lsp.inlay_hint.toggle({ bufnr = bufnr })
				end, "[T]oggle Inlay [H]ints")
			end
		end

		-- List of LSP servers (corresponding filenames in lua/lsp/)
		local servers = { "pyright", "html", "lua_ls" } -- add others as needed

		-- Ensure Mason installs all servers automatically
		local ensure_installed = vim.tbl_map(function(s)
			return s
		end, servers)
		vim.list_extend(ensure_installed, { "stylua" }) -- example tool
		mason_tool_installer.setup({ ensure_installed = ensure_installed })

		-- Loop through servers and load their configs
		for _, server in ipairs(servers) do
			local ok, server_opts = pcall(require, "lsp." .. server)
			if ok then
				server_opts.capabilities =
					vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})
				server_opts.on_attach = on_attach
				if not server_opts.root_dir then
					server_opts.root_dir = lspconfig.util.root_pattern(
						"pyproject.toml",
						".git",
						"setup.py",
						"setup.cfg",
						"requirements.txt"
					)
				end
				lspconfig[server].setup(server_opts)
			else
				vim.notify("Failed to load LSP config for " .. server, vim.log.levels.WARN)
			end
		end
	end,
}
