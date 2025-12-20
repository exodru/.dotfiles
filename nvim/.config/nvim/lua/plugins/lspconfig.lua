return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason-org/mason-lspconfig.nvim" },
		config = function()
			-- 1. Fetch capabilities from Blink
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- 2. Define server list (Fixed typos and removed non-LSP formatter)
			local servers = { "lua_ls", "clangd", "basedpyright", "gopls", "ts_ls", "texlab" }

			-- 3. Register configs

			-- C++ (Added capabilities here)
			vim.lsp.config("clangd", {
				capabilities = capabilities,
				cmd = { "clangd", "--background-index", "--clang-tidy" },
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
				root_markers = {
					".clangd",
					".clang-tidy",
					".clang-format",
					"compile_commands.json",
					"compile_flags.txt",
					"configure.ac",
					".git",
				},
			})

			-- Lua
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			})

			-- Python (Ensure name matches 'basedpyright' in the servers list)
			vim.lsp.config("basedpyright", {
				cmd = { "basedpyright-langserver", "--stdio" },
				filetypes = { "python" },
				capabilities = capabilities,
				root_markers = {
					"pyproject.toml",
					"setup.py",
					"requirements.txt",
					".git",
				},
				settings = {
					basedpyright = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "openFilesOnly",
						},
					},
				},
			})

			-- LaTeX (Texlab)
			vim.lsp.config("texlab", {
				capabilities = capabilities,
				cmd = { "texlab" },
				filetypes = { "tex", "plaintex", "bib" },
				root_markers = { ".git", ".latexmkrc", "main.tex", "." },
				settings = {
					texlab = {
						build = {
							experimental = {
								-- this allows texlab to try and find documentation for commands
								documentation = true,
							},
							executable = "latexmk",
							args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
						},
						latexFormatter = "latexindent",
					},
				},
			})

			-- TypeScript/JS
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				cmd = { "typescript-language-server", "--stdio" },
			})

			-- 4. Enable servers
			vim.lsp.enable(servers)

			-- 5. Keymaps (modern 0.11+ way using LspAttach)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)

					-- Enable Inlay Hints (if supported)
					if client and client.supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
					end

					local opts = { buffer = args.buf }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gsh", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "gca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gre", vim.lsp.buf.references, opts)
				end,
			})

			-- 5. diagnostics for every language server
			vim.diagnostic.config({
				virtual_text = true,
				update_in_insert = true,
				signs = true,
				underline = true,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always", -- show which LSP (clangd, lua_ls, etc.) sent the error
				},
			})
		end,
	},
}
