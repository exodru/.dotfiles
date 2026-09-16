vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/creativenull/efmls-configs-nvim",
	{
		src = "https://github.com/saghen/blink.cmp",
		version = "v1.10.2", -- branch required for v1 setup
	},
	"https://github.com/L3MON4D3/LuaSnip", -- snippet dependency used by blink configuration
	"https://github.com/mrcjkb/rustaceanvim", -- handles rust separate from lspconfig
	"https://github.com/ibhagwan/fzf-lua",
})

-- ============================================================================
-- LSP, LINTING & COMPLETION DEFINITIONS
-- ============================================================================

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"pyright",
		"bashls",
		"ts_ls",
		"gopls",
		"clangd",
		"efm",
		"dockerls",
		"texlab",
	},
})

local diagnostic_signs = { Error = " ", Warn = " ", Hint = "  ", Info = " " }
vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = true, header = "", prefix = "", focusable = false, style = "minimal" },
})

-- force floating borders globally
do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

-- keybindings applied dynamically when an LSP mounts to a buffer
local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end
	local bufnr = ev.buf
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "<leader>gd", function()
		require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
	end, opts)
	vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "<leader>gS", function()
		vim.cmd("vsplit")
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>D", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>fr", function()
		require("fzf-lua").lsp_references()
	end, opts)
	vim.keymap.set("n", "<leader>ft", function()
		require("fzf-lua").lsp_typedefs()
	end, opts)
	vim.keymap.set("n", "<leader>fs", function()
		require("fzf-lua").lsp_document_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fw", function()
		require("fzf-lua").lsp_workspace_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fi", function()
		require("fzf-lua").lsp_implementations()
	end, opts)

	if client:supports_method("textDocument/codeAction", bufnr) then
		vim.keymap.set("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
				bufnr = bufnr,
			})
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, opts)
	end
end

local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", { group = lsp_group, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })

-- defer blink initialization to break execution loop
vim.schedule(function()
	local blink = require("blink.cmp")
	blink.setup({
		keymap = {
			preset = "none",
			["<C-Space>"] = { "show", "hide" },
			["<CR>"] = { "accept", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
		},
		appearance = { nerd_font_variant = "mono" },
		completion = { menu = {
			auto_show = function()
				return vim.bo.filetype ~= "markdown"
			end,
		} },
		sources = { default = { "lsp", "path", "buffer", "snippets" } },
		snippets = {
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
		},
		fuzzy = { implementation = "prefer_rust", prebuilt_binaries = { download = true } },
	})

	-- assign capabilities to servers globally right after setup finishes
	vim.lsp.config["*"] = { capabilities = blink.get_lsp_capabilities() }

	-- sync capabilities to standalone rustacean module dynamically
	vim.g.rustaceanvim = { server = { capabilities = blink.get_lsp_capabilities() } }
end)

-- define language server declarations
vim.lsp.config(
	"lua_ls",
	{ settings = { Lua = { diagnostics = { globals = { "vim" } }, telemetry = { enable = false } } } }
)
vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})
vim.lsp.config("dockerls", {})
vim.lsp.config("texlab", {})

-- configure EFM
local luacheck = require("efmls-configs.linters.luacheck")
local stylua = require("efmls-configs.formatters.stylua")
local flake8 = require("efmls-configs.linters.flake8")
local black = require("efmls-configs.formatters.black")
local prettier_d = require("efmls-configs.formatters.prettier_d")
local eslint_d = require("efmls-configs.linters.eslint_d")
local fixjson = require("efmls-configs.formatters.fixjson")
local shellcheck = require("efmls-configs.linters.shellcheck")
local shfmt = require("efmls-configs.formatters.shfmt")
local cpplint = require("efmls-configs.linters.cpplint")
local clangfmt = require("efmls-configs.formatters.clang_format")
local go_revive = require("efmls-configs.linters.go_revive")
local gofumpt = require("efmls-configs.formatters.gofumpt")
local latexindent = require("efmls-configs.formatters.latexindent")

vim.lsp.config("efm", {
	filetypes = {
		"c",
		"cpp",
		"css",
		"go",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"lua",
		"markdown",
		"python",
		"sh",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
		"tex",
		"latex",
	},
	init_options = { documentFormatting = true, documentFormattingProvider = true },
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = true
		client.server_capabilities.documentRangeFormattingProvider = true
	end,
	settings = {
		languages = {
			c = { clangfmt, cpplint },
			go = { gofumpt, go_revive },
			cpp = { clangfmt, cpplint },
			css = { prettier_d },
			html = { prettier_d },
			javascript = { eslint_d, prettier_d },
			javascriptreact = { eslint_d, prettier_d },
			json = { eslint_d, fixjson },
			jsonc = { eslint_d, fixjson },
			lua = { luacheck, stylua },
			markdown = { prettier_d },
			python = { flake8, black },
			sh = { shellcheck, shfmt },
			typescript = { eslint_d, prettier_d },
			typescriptreact = { eslint_d, prettier_d },
			vue = { eslint_d, prettier_d },
			svelte = { eslint_d, prettier_d },
			tex = { latexindent },
			latex = { latexindent },
		},
	},
})

-- enable servers all together
vim.lsp.enable({ "lua_ls", "pyright", "bashls", "ts_ls", "gopls", "clangd", "dockerls", "texlab", "efm" })

-- format on save autocommand
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	pattern = {
		"*.lua",
		"*.py",
		"*.go",
		"*.js",
		"*.jsx",
		"*.ts",
		"*.tsx",
		"*.json",
		"*.css",
		"*.scss",
		"*.html",
		"*.sh",
		"*.bash",
		"*.zsh",
		"*.c",
		"*.cpp",
		"*.h",
		"*.hpp",
		"*.tex",
		"*.bib",
	},
	callback = function(args)
		-- escape non-standard scratch/help/terminal buffers
		if vim.bo[args.buf].buftype ~= "" or not vim.bo[args.buf].modifiable then
			return
		end

		-- check if efm is actively running on this buffer
		local efm_active = false
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
			if client.name == "efm" then
				efm_active = true
				break
			end
		end

		-- trigger formatting explicitly via EFM
		if efm_active then
			vim.lsp.buf.format({
				bufnr = args.buf,
				timeout_ms = 2000,
				name = "efm", -- forces nvim to bypass other LSPs and use EFM directly
			})
		end
	end,
})
