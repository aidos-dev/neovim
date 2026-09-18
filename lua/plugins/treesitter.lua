return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"bash",
				"go",
				"gomod",
				"gosum",
				"json",
				"yaml",
				"markdown",
				"markdown_inline",
			}

			require("nvim-treesitter").install(ensure_installed)

			-- foldmethod=expr defaults foldlevel to 0 (everything collapsed);
			-- start with folds open instead.
			vim.o.foldlevelstart = 99

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local lang = vim.treesitter.language.get_lang(args.match) or args.match
					local ok = pcall(vim.treesitter.start, args.buf, lang)
					if ok then
						vim.wo[0][0].foldmethod = "expr"
						vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}
