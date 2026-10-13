return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "gopls", "clangd", "zls", "ts_ls"}
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			vim.lsp.config('*', {
				capabilities = capabilities,
			})

			vim.lsp.config('clangd', {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
					"--query-driver=/usr/bin/g++,/usr/bin/clang++",
				},
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
				root_markers = {
					'.clangd',
					'.clang-tidy',
					'.clang-format',
					'compile_commands.json',
					'compile_flags.txt',
					'configure.ac',
					'.git',
				},
			})

			vim.lsp.enable({ "lua_ls", "gopls", "clangd", "zls", "ts_ls" })

			-- LSP keybindings
			-- K (hover) is a built-in default
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

			-- Diagnostic keybindings
			vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostic error" })
		end
	},
}
